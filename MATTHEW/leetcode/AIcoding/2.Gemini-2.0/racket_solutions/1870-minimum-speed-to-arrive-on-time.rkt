(define (min-speed-on-time dist hour)
  (define n (length dist))
  (define (possible? speed)
    (let loop ([i 0] [time 0.0])
      (cond
        [(= i (- n 1))
         (<= (+ time (/ (list-ref dist i) speed)) hour)]
        [else
         (let ([new-time (+ time (ceiling (/ (list-ref dist i) speed)))])
           (if (> new-time hour)
               #f
               (loop (+ i 1) new-time)))])))

  (let loop ([low 1] [high 10000000])
    (cond
      [(> low high) -1]
      [else
       (let ([mid (quotient (+ low high) 2)])
         (if (possible? mid)
             (let ([lower-speed (loop low (- mid 1))])
               (if (= lower-speed -1)
                   mid
                   lower-speed))
             (loop (+ mid 1) high)))])))