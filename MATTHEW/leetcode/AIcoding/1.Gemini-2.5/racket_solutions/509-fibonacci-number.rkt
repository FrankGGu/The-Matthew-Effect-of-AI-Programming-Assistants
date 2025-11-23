(define (fib n)
  (cond
    [(zero? n) 0]
    [(= n 1) 1]
    [else
     (let loop ([i 2]
                [f-prev-prev 0]
                [f-prev 1])
       (if (= i n)
           (+ f-prev-prev f-prev)
           (loop (+ i 1)
                 f-prev
                 (+ f-prev-prev f-prev))))]))