(define (minimumTimeToInitialState s k)
  (let ([n (string-length s)])
    (let loop ([time 1] [start k])
      (if (>= start n)
          time
          (if (string=? (substring s 0 (- n start)) (substring s start n))
              time
              (loop (+ 1 time) (+ k start)))))))