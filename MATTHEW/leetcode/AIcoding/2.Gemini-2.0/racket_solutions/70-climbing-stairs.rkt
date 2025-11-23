(define (climb-stairs n)
  (cond
    [(<= n 0) 0]
    [(= n 1) 1]
    [(= n 2) 2]
    [else
     (let loop ([i 3] [a 1] [b 2])
       (if (> i n)
           b
           (loop (+ i 1) b (+ a b))))]))