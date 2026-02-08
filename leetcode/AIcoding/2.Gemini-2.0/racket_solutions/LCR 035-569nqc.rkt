(define (find-min-difference timePoints)
  (let* ([minutes (map (lambda (time)
                         (let ([parts (string-split time ":")])
                           (+ (* (string->number (car parts)) 60)
                              (string->number (cadr parts)))))
                       timePoints)]
         [sorted-minutes (sort minutes <)])
    (let loop ([mins sorted-minutes]
               [min-diff 1440])
      (cond
        [(null? (cdr mins))
         (min min-diff (- (car mins) (last sorted-minutes) 1440))]
        [else
         (loop (cdr mins) (min min-diff (- (cadr mins) (car mins))))]))))