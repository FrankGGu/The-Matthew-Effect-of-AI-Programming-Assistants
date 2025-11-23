(define (time-required-to-buy tickets k)
  (let loop ([tickets tickets] [time 0])
    (cond
      [(null? tickets) time]
      [(zero? (car tickets)) (loop (cdr tickets) time)]
      [else
       (let ([new-tickets (cons (sub1 (car tickets)) (cdr tickets))])
         (if (zero? k)
             (add1 time)
             (loop (append new-tickets (list (car new-tickets)))
                   (add1 time)
                   (sub1 k))))])))