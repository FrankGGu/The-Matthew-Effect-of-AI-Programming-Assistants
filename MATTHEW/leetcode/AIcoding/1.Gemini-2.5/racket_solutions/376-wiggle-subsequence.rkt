(define (wiggle-subsequence nums)
  (cond
    [(empty? nums) 0]
    [else
     (let loop ([lst (rest nums)]
                [prev (first nums)]
                [up 1]
                [down 1])
       (if (empty? lst)
           (max up down)
           (let ([curr (first lst)])
             (cond
               [(> curr prev)
                (loop (rest lst) curr (+ down 1) down)]
               [(< curr prev)
                (loop (rest lst) curr up (+ up 1))]
               [else
                (loop (rest lst) curr up down)]))))]))