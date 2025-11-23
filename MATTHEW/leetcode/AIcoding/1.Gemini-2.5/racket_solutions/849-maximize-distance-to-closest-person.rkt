(define (max-dist-to-closest-person seats)
  (let* ([n (length seats)]
         [one-indices
          (for/list ([seat seats]
                     [i (in-naturals)]
                     #:when (= seat 1))
            i)])
    (if (empty? one-indices)
        0
        (let* ([first-one (car one-indices)]
               [last-one (last one-indices)]
               [max-d-initial (max first-one (- (sub1 n) last-one))])
          (for/fold ([max-d max-d-initial]
                     [prev-one first-one])
                    ([current-one (cdr one-indices)])
            (values (max max-d (quotient (- current-one prev-one) 2))
                    current-one))))))