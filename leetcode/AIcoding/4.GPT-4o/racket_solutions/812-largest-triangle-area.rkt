(define (largestTriangleArea points)
  (define (area p1 p2 p3)
    (abs (/ (* (- (car p1) (car p3)) (- (cadr p2) (cadr p3)))
             2.0)))
  (define max-area 0)
  (for* ([i (in-range (length points))]
         [j (in-range (add1 i) (length points))]
         [k (in-range (add1 j) (length points))])
    (set! max-area (max max-area (area (list-ref points i) (list-ref points j) (list-ref points k)))))
  max-area)