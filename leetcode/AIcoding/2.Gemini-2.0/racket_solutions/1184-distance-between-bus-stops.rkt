(define (distance-between-bus-stops distance start destination)
  (let* ([n (length distance)]
         [total-sum (apply + distance)]
         [clockwise-sum (let loop ([i start] [sum 0])
                           (if (= i destination)
                               sum
                               (loop (modulo (+ i 1) n) (+ sum (list-ref distance i)))))]
         [counterclockwise-sum (- total-sum clockwise-sum)])
    (min clockwise-sum counterclockwise-sum)))