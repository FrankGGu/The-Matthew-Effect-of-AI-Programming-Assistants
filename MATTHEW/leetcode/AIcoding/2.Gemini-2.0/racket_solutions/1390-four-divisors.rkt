(define (four-divisors nums)
  (define (count-divisors n)
    (let loop ([i 1] [count 0] [sum 0])
      (cond
        [(> i (sqrt n))
         (if (= count 2)
             (+ sum n 1)
             0)]
        [(= (remainder n i) 0)
         (if (= i (/ n i))
             (loop (+ i 1) (+ count 1) sum)
             (loop (+ i 1) (+ count 2) (+ sum i (/ n i))))
        ]
        [else
         (loop (+ i 1) count sum)])))

  (apply + (map count-divisors nums)))