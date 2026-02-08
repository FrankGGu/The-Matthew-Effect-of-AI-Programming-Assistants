(define (count-numbers-with-unique-digits n)
  (cond
    [(zero? n) 1]
    [(= n 1) 10]
    [else
     (let loop ([i 2] [ans 10] [prod 9])
       (if (> i n)
           ans
           (loop (+ i 1) (+ ans (* prod (- 10 i))) (* prod (- 10 i)))))]))