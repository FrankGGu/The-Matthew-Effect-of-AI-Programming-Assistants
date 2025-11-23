(define (check-straight-line points)
  (define (slope p1 p2)
    (if (= (- (car p2) (car p1)) 0)
        'inf
        (/ (- (cdr p2) (cdr p1)) (- (car p2) (car p1)))))
  (define initial-slope (slope (list-ref points 0) (list-ref points 1)))
  (for/fold ([is-straight #t]) ([i (in-range 2 (length points))])
    (if (equal? (slope (list-ref points (- i 1)) (list-ref points i)) initial-slope)
        is-straight
        #f)))