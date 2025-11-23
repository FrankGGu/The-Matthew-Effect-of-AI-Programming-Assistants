(define/contract (largest-time-from-digits arr)
  (-> (listof exact-integer?) string?)
  (define perms (permutations arr))
  (define valid-times
    (filter (lambda (p)
              (let ([h (+ (* 10 (first p)) (second p))]
                    [m (+ (* 10 (third p)) (fourth p))])
                (and (< h 24) (< m 60))))
            perms))
  (if (null? valid-times)
      ""
      (let* ([best (argmax (lambda (p)
                             (+ (* 1000 (first p))
                                (* 100 (second p))
                                (* 10 (third p))
                                (fourth p))))
                           valid-times)]
             [h1 (first best)]
             [h2 (second best)]
             [m1 (third best)]
             [m2 (fourth best)])
        (string-append (number->string h1)
                       (number->string h2)
                       ":"
                       (number->string m1)
                       (number->string m2)))))