(define (calculate-money n)
  (let* ((num-weeks (quotient n 7))
         (remaining-days (remainder n 7)))
    (let ((sum-full-weeks
           (+ (* 7 (/ (* num-weeks (+ num-weeks 1)) 2))
              (* 21 num-weeks)))
          (sum-remaining-days
           (if (> remaining-days 0)
               (/ (* remaining-days
                     (+ (+ num-weeks 1)
                        (+ num-weeks remaining-days)))
                  2)
               0)))
      (+ sum-full-weeks sum-remaining-days))))