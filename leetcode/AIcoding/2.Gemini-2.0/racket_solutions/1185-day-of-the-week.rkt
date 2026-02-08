(define (day-of-the-week day month year)
  (let* ([m (if (<= month 2) (+ month 12) month)]
         [y (if (<= month 2) (- year 1) year)]
         [K (remainder y 100)]
         [J (quotient y 100)]
         [h (remainder (+ day (quotient (* 13 (+ m 1)) 5) K (quotient K 4) (quotient J 4) (- (* 2 J))) 7)])
    (cond
      [(= h 0) "Sunday"]
      [(= h 1) "Monday"]
      [(= h 2) "Tuesday"]
      [(= h 3) "Wednesday"]
      [(= h 4) "Thursday"]
      [(= h 5) "Friday"]
      [(= h 6) "Saturday"])))