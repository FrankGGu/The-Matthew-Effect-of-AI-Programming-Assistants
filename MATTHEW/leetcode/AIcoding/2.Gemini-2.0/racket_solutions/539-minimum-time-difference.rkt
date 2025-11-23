(define (minimum-time-difference time-points)
  (let* ([minutes (map (lambda (time)
                         (let ([parts (string-split time ":")])
                           (+ (* (string->number (car parts)) 60)
                              (string->number (cadr parts)))))
                       time-points)]
         [sorted-minutes (sort minutes <)]
         [n (length sorted-minutes)])
    (let loop ([i 1] [min-diff 1440])
      (if (= i n)
          (min min-diff (- (+ 1440 (car sorted-minutes)) (last sorted-minutes)))
          (loop (+ i 1) (min min-diff (- (list-ref sorted-minutes i) (list-ref sorted-minutes (- i 1)))))))))