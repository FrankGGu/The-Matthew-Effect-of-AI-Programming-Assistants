(define (minTimeToVisitAllPoints points)
  (define (distance p1 p2)
    (max (abs (- (car p1) (car p2))) (abs (- (cadr p1) (cadr p2)))))
  (define (helper points)
    (if (null? (cdr points))
        0
        (+ (distance (car points) (cadr points)) (helper (cdr points)))))
  (helper points))