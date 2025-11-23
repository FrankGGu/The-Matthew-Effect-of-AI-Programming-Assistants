(define (time-needed-to-buy-tickets tickets k)
  (let loop ([tickets tickets] [time 0])
    (if (every? zero? tickets)
        time
        (let ([n (length tickets)])
          (loop (map (lambda (i t) (if (> t 0) (sub1 t) t)) (range n) tickets)
                (add1 time))))))