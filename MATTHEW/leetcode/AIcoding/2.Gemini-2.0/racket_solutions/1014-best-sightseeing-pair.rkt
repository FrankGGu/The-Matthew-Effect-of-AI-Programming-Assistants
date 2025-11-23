(define (max-score values)
  (let* ([n (length values)]
         [max-so-far (car values)]
         [max-score 0])
    (for/fold ([max-score max-score]
               [max-so-far max-so-far]
               [i (in-range 1 n)])
      ([value (in-list values)])
      (let ([curr-score (+ max-so-far value (- i))])
        (values (max max-score curr-score)
                (max max-so-far (+ value i)))))))