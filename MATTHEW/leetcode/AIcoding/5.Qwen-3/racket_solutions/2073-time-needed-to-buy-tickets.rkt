(define (time-needed-to-buy tickets k)
  (define (helper tickets k time)
    (cond [(null? tickets) time]
          [(= (car tickets) 0) (helper (cdr tickets) k time)]
          [else
           (let ([new-time (+ time 1)])
             (if (= k 0)
                 new-time
                 (helper (cons (- (car tickets) 1) (cdr tickets)) (sub1 k) new-time)))]))
  (helper tickets k 0))