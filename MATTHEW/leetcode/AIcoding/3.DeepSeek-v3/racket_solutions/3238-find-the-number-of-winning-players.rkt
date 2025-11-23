(define (number-of-winning-players scores k)
  (let loop ([scores (sort scores >)]
             [count 0]
             [prev -inf.0]
             [streak 0])
    (cond
      [(null? scores) count]
      [(> (car scores) prev)
       (loop (cdr scores) 
             (if (>= (add1 streak) k) (add1 count) count)
             (car scores)
             (add1 streak))]
      [else
       (loop (cdr scores) 
             (if (>= (add1 streak) k) (add1 count) count)
             (car scores)
             1)])))