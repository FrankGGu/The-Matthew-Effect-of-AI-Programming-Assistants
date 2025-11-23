(define (distinct-values-on-diagonals grid)
  (let* ((m (length grid))
         (n (length (first grid)))
         (result (make-vector m (make-vector n 0))))
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (let* ((distinct-up-left (set))
               (distinct-down-right (set))
               (x i)
               (y j))

          ;; Up-left diagonal
          (let loop-up-left ()
            (cond
              [(and (>= x 0) (>= y 0))
               (set-add! distinct-up-left (vector-ref (vector-ref grid x) y))
               (set! x (- x 1))
               (set! y (- y 1))
               (loop-up-left)]
              [else #f]))

          ;; Down-right diagonal
          (set! x i)
          (set! y j)
          (let loop-down-right ()
            (cond
              [(and (< x m) (< y n))
               (set-add! distinct-down-right (vector-ref (vector-ref grid x) y))
               (set! x (+ x 1))
               (set! y (+ y 1))
               (loop-down-right)]
              [else #f]))

          (vector-set! (vector-ref result i) j (abs (- (set-count distinct-up-left) (set-count distinct-down-right)))))))
    result))