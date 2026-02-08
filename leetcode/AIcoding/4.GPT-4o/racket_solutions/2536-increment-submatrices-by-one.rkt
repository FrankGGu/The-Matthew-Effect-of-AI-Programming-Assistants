(define (increment-submatrices matrix)
  (define (add-one r1 c1 r2 c2)
    (for ([i (in-range r1 (+ r2 1))])
      (for ([j (in-range c1 (+ c2 1))])
        (set! (matrix-ref matrix i j) (+ (matrix-ref matrix i j) 1)))))

  (for ([i (in-range (vector-length matrix))])
    (for ([j (in-range (vector-length (vector-ref matrix 0)))])
      (if (not (= (matrix-ref matrix i j) 0))
          (add-one i j i j))))

  matrix)

(define (matrix-ref m r c)
  (vector-ref (vector-ref m r) c))

(define (incrementSubmatrices matrix)
  (increment-submatrices matrix))