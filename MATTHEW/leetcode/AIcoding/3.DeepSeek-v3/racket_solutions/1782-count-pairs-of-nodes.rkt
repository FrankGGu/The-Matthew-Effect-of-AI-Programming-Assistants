#lang racket

(require data/heap)

(define/contract (count-pairs n edges queries)
  (-> exact-integer? (listof (listof exact-integer?)) (listof exact-integer?) (listof exact-integer?))
  (let* ([degree (make-vector n 0)]
         [edge-count (make-hash)]
         [sorted-degrees (make-heap (lambda (a b) (<= a b)))])
    (for ([edge edges])
      (let ([u (sub1 (first edge))]
            [v (sub1 (second edge))])
        (vector-set! degree u (add1 (vector-ref degree u)))
        (vector-set! degree v (add1 (vector-ref degree v)))
        (let ([key (if (< u v) (cons u v) (cons v u))])
          (hash-update! edge-count key (lambda (x) (add1 x)) 0))))
    (for ([i (in-range n)])
      (heap-add! sorted-degrees (vector-ref degree i)))
    (let ([sorted-degrees-list (heap->list sorted-degrees)])
      (for/list ([q queries])
        (let ([res 0])
          (let loop ([i 0] [j (sub1 n)])
            (when (< i j)
              (if (> (+ (list-ref sorted-degrees-list i)
                         (list-ref sorted-degrees-list j))
                      q)
                  (begin
                    (set! res (+ res (- j i)))
                    (loop i (sub1 j)))
                  (loop (add1 i) j)))))
          (for ([(key cnt) (in-hash edge-count)])
            (let ([u (car key)]
                  [v (cdr key)])
              (when (> (+ (vector-ref degree u) (vector-ref degree v) (- cnt)) q)
                (set! res (sub1 res)))))
          res))))