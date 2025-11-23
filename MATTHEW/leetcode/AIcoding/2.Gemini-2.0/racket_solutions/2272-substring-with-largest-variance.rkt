(provide (contract-out
          [largestVariance (-> string? exact-integer?)]))

(define (largestVariance s)
  (define n (string-length s))
  (define chars (set->list (string->set s)))
  (let loop ([max-variance 0]
             [i 0])
    (if (= i (length chars))
        max-variance
        (let loop2 ([j (add1 i)])
          (if (= j (length chars))
              (loop max-variance (add1 i))
              (let ([major (list-ref chars i)]
                     [minor (list-ref chars j)])
                (let loop3 ([curr-max 0]
                            [curr-min 0]
                            [variance 0]
                            [k 0])
                  (if (= k n)
                      (loop2 (max max-variance variance) (add1 j))
                      (let ([c (string-ref s k)])
                        (cond
                          [(char=? c major)
                           (loop3 (add1 curr-max) curr-min
                                  (max variance (- curr-max curr-min))
                                  (add1 k))]
                          [(char=? c minor)
                           (if (= curr-max 0)
                               (loop3 curr-max (add1 curr-min)
                                      variance (add1 k))
                               (loop3 curr-max (add1 curr-min)
                                      (max variance (- curr-max curr-min))
                                      (add1 k)))]
                          [else
                           (loop3 curr-max curr-min variance (add1 k))])))))
                (let loop4 ([curr-max 0]
                            [curr-min 0]
                            [variance 0]
                            [k 0])
                  (if (= k n)
                      (loop2 (max max-variance variance) (add1 j))
                      (let ([c (string-ref s k)])
                        (cond
                          [(char=? c minor)
                           (loop4 (add1 curr-max) curr-min
                                  (max variance (- curr-max curr-min))
                                  (add1 k))]
                          [(char=? c major)
                           (if (= curr-max 0)
                               (loop4 curr-max (add1 curr-min)
                                      variance (add1 k))
                               (loop4 curr-max (add1 curr-min)
                                      (max variance (- curr-max curr-min))
                                      (add1 k)))]
                          [else
                           (loop4 curr-max curr-min variance (add1 k))]))))))))))))