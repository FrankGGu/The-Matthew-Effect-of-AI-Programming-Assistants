(define (regionsCutBySlashes grid)
  (define N (length grid))
  (define num-nodes (* 4 N N))
  (define parent (make-vector num-nodes 0))

  ;; Initialize parent array: each element is its own parent
  (for ([i (in-range num-nodes)])
    (vector-set! parent i i))

  ;; Find function with path compression
  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (let ([root (find (vector-ref parent i))])
          (vector-set! parent i root)
          root)))

  ;; Union function
  ;; Returns #t if a merge happened (roots were different),
  ;; #f if they were already in the same set (a cycle is formed).
  (define (union i j)
    (let ([root-i (find i)]
          [root-j (find j)])
      (if (= root-i root-j)
          #f ; Already in the same set, a cycle is formed
          (begin
            (vector-set! parent root-j root-i)
            #t)))) ; Merged successfully

  (define regions 1) ; Start with 1 region (the entire grid)

  (for ([r (in-range N)])
    (for ([c (in-range N)])
      (define cell-base-idx (* (+ (* r N) c) 4))

      ;; Connect regions within the current cell based on the character
      (define char (string-ref (list-ref grid r) c))
      (case char
        [(#\space)
         ;; Connect all 4 parts: 0-1, 1-2, 2-3
         (when (not (union (+ cell-base-idx 0) (+ cell-base-idx 1))) (set! regions (add1 regions)))
         (when (not (union (+ cell-base-idx 1) (+ cell-base-idx 2))) (set! regions (add1 regions)))
         (when (not (union (+ cell-base-idx 2) (+ cell-base-idx 3))) (set! regions (add1 regions)))]
        [(#\/)
         ;; Connect 0-3 and 1-2
         (when (not (union (+ cell-base-idx 0) (+ cell-base-idx 3))) (set! regions (add1 regions)))
         (when (not (union (+ cell-base-idx 1) (+ cell-base-idx 2))) (set! regions (add1 regions)))]
        [(#\\)
         ;; Connect 0-1 and 2-3
         (when (not (union (+ cell-base-idx 0) (+ cell-base-idx 1))) (set! regions (add1 regions)))
         (when (not (union (+ cell-base-idx 2) (+ cell-base-idx 3))) (set! regions (add1 regions)))]))

      ;; Connect adjacent cells
      ;; Connect bottom (part 2) of current cell to top (part 0) of cell below
      (when (< (add1 r) N)
        (define current-cell-bottom (+ cell-base-idx 2))
        (define below-cell-top (+ (* (+ (* (add1 r) N) c) 4) 0))
        (when (not (union current-cell-bottom below-cell-top)) (set! regions (add1 regions))))

      ;; Connect right (part 1) of current cell to left (part 3) of cell to its right
      (when (< (add1 c) N)
        (define current-cell-right (+ cell-base-idx 1))
        (define right-cell-left (+ (* (+ (* r N) (add1 c)) 4) 3))
        (when (not (union current-cell-right right-cell-left)) (set! regions (add1 regions))))))

  regions)