(define (day-of-the-week day month year)
  (let* ([days '("Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")]
         [a (quotient (- 14 month) 12)]
         [y (- year a)]
         [m (+ month (* 12 a) -2)]
         [d (modulo (+ day y (quotient y 4) (quotient y 400) (- (quotient y 100)) (quotient (* 31 m) 12)) 7)])
    (list-ref days d)))