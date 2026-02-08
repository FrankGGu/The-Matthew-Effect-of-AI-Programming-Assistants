(define (max-manhattan-distance points k)
  (define (calculate-distance p1 p2)
    (+ (abs (- (car p1) (car p2))) (abs (- (cdr p1) (cdr p2)))))

  (define (max-distance points k current-max)
    (cond
      [(empty? points) current-max]
      [else
       (let* ([current-point (car points)]
              [remaining-points (cdr points)]
              [max-with-current (foldl (lambda (p acc) (max acc (calculate-distance current-point p))) 0 remaining-points)]
              [new-max (max current-max max-with-current)])
         (max-distance remaining-points k new-max))]))

  (max-distance points k 0))

(provide max-manhattan-distance)