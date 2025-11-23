(define (maxAreaOfDiagonalRectangle points)
  (define (distance p1 p2)
    (sqrt (+ (expt (- (car p1) (car p2)) 2)
             (expt (- (cadr p1) (cadr p2)) 2))))
  (define (max-area pts)
    (for*/list ([i (in-range (length pts))]
                 [j (in-range (add1 i) (length pts))])
      (let* ([d1 (distance (list-ref pts i) (list-ref pts j))]
             [d2 (distance (list-ref pts j) (list-ref pts i))])
        (* d1 d2))))
  (apply max (max-area points)))

(maxAreaOfDiagonalRectangle '((1 2) (3 4) (5 6) (7 8)))