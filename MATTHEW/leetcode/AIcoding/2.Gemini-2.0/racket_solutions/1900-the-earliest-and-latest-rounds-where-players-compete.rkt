(define (earliest-and-latest-rounds n first-player second-player)
  (define (solve n first second)
    (let* ([rounds (integer-length (- n 1))]
           [memo (make-hash)])
      (define (recur n first second round)
        (cond
          [(= first second)
           (values #f #f)]
          [(>= first second)
           (recur n second first round)]
          [(= 1 (hash-ref memo (list n first second round) #f))
           (values #f #f)]
          [(= first (ceiling (/ n 2)) )
           (cond
             [(= second (+ first 1))
              (values round round)]
             [else
              (values round round)])]
          [else
           (hash-set! memo (list n first second round) 1)
           (let ([earliest #f]
                 [latest #f])
             (for ([i (in-range (ceiling (/ n 2)))])
               (for ([j (in-range (ceiling (/ n 2)))])
                 (let* ([new-first (if (<= i first)
                                       (if (odd? first)
                                           (quotient (+ first 1) 2)
                                           (quotient first 2))
                                       (if (<= i second)
                                           (if (odd? second)
                                               (quotient (+ second 1) 2)
                                               (quotient second 2))
                                           (+ (ceiling (/ n 2)) 1)))
                         [new-second (if (<= j first)
                                        (if (odd? first)
                                            (quotient (+ first 1) 2)
                                            (quotient first 2))
                                        (if (<= j second)
                                            (if (odd? second)
                                                (quotient (+ second 1) 2)
                                                (quotient second 2))
                                            (+ (ceiling (/ n 2)) 1)))
                         [new-n (ceiling (/ n 2))])
                   (when (and (<= 1 new-first new-n) (<= 1 new-second new-n))
                     (let-values ([(e l) (recur new-n new-first new-second (+ round 1))])
                       (when e
                         (cond
                           [(not earliest)
                            (set! earliest e)
                            (set! latest l)]
                           [else
                            (set! earliest (min earliest e))
                            (set! latest (max latest l))])))))))
             (values earliest latest))]))))
      (recur n first second 1)))
  (solve n first-player second-player))