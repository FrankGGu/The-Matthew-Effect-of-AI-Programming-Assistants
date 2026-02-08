(define (range-add-submatrices n queries)
  ;; Initialize an n x n matrix with zeros. This will serve as the difference array.
  (define matrix (make-vector n (lambda () (make-vector n 0))))

  ;; Process each query to update the difference array
  (for-each (lambda (query)
              (define r1 (vector-ref query 0))
              (define c1 (vector-ref query 1))
              (define r2 (vector-ref query 2))
              (define c2 (vector-ref query 3))

              ;; Increment at (r1, c1)
              (vector-set! (vector-ref matrix r1) c1
                           (+ (vector-ref (vector-ref matrix r1) c1) 1))

              ;; Decrement at (r1, c2 + 1) if within bounds
              (when (< (+ c2 1) n)
                (vector-set! (vector-ref matrix r1) (+ c2 1)
                             (- (vector-ref (vector-ref matrix r1) (+ c2 1)) 1)))

              ;; Decrement at (r2 + 1, c1) if within bounds
              (when (< (+ r2 1) n)
                (vector-set! (vector-ref matrix (+ r2 1)) c1
                             (- (vector-ref (vector-ref matrix (+ r2 1)) c1) 1)))

              ;; Increment at (r2 + 1, c2 + 1) if both are within bounds
              (when (and (< (+ r2 1) n) (< (+ c2 1) n))
                (vector-set! (vector-ref matrix (+ r2 1)) (+ c2 1)
                             (+ (vector-ref (vector-ref matrix (+ r2 1)) (+ c2 1)) 1))))
            queries)

  ;; Compute 2D prefix sums to transform the difference array into the final result matrix
  (for* ([r (in-range n)]
         [c (in-range n)])
    (define current-diff-val (vector-ref (vector-ref matrix r) c))

    (define val-above (if (> r 0) (vector-ref (vector-ref matrix (- r 1)) c) 0))
    (define val-left (if (> c 0) (vector-ref (vector-ref matrix r) (- c 1)) 0))
    (define val-diag (if (and (> r 0) (> c 0)) (vector-ref (vector-ref matrix (- r 1)) (- c 1)) 0))

    ;; The value at (r, c) is the sum of current_diff_val + value_above + value_left - value_diagonal_above_left
    (vector-set! (vector-ref matrix r) c
                 (+ current-diff-val val-above val-left (- val-diag))))

  matrix)