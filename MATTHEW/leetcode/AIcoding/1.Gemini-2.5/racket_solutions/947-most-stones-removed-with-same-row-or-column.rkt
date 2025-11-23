#lang racket

(define (remove-stones stones)
  (define n (length stones))
  (if (zero? n) 0
      (begin
        ;; DSU parent array
        (define parent (make-vector n))
        (for ([i (in-range n)])
          (vector-set! parent i i))

        ;; Find operation with path compression
        (define (find i)
          (if (= (vector-ref parent i) i)
              i
              (begin
                (vector-set! parent i (find (vector-ref parent i)))
                (vector-ref parent i))))

        ;; Union operation (simple, without rank/size optimization, but path compression helps)
        (define (union i j)
          (let ([root-i (find i)]
                [root-j (find j)])
            (unless (= root-i root-j)
              (vector-set! parent root-i root-j))))

        ;; Hash tables to group stone indices by row and column
        (define row-to-stones (make-hash)) ; row-value -> list of stone indices
        (define col-to-stones (make-hash)) ; col-value -> list of stone indices

        ;; Populate hash tables
        (for ([i (in-range n)])
          (let* ([stone-coords (list-ref stones i)]
                 [r (car stone-coords)]
                 [c (cadr stone-coords)])
            (hash-set! row-to-stones r (cons i (hash-ref row-to-stones r '())))
            (hash-set! col-to-stones c (cons i (hash-ref col-to-stones c '())))))

        ;; Perform unions for stones in the same row
        (hash-for-each
         row-to-stones
         (lambda (r stone-indices)
           (when (> (length stone-indices) 1) ; Only union if there's more than one stone
             (let ([first-stone (car stone-indices)])
               (for ([other-stone (cdr stone-indices)])
                 (union first-stone other-stone))))))

        ;; Perform unions for stones in the same column
        (hash-for-each
         col-to-stones
         (lambda (c stone-indices)
           (when (> (length stone-indices) 1) ; Only union if there's more than one stone
             (let ([first-stone (car stone-indices)])
               (for ([other-stone (cdr stone-indices)])
                 (union first-stone other-stone))))))

        ;; Count the number of connected components
        (define num-components 0)
        (for ([i (in-range n)])
          (when (= (vector-ref parent i) i)
            (set! num-components (+ num-components 1))))

        ;; The maximum number of stones that can be removed is N - num_components
        (- n num-components))))