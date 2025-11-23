(define (min-sessions tasks session-time)
  (define n (length tasks))
  (define (solve mask)
    (cond
      [(equal? mask (expt 2 n)) 0]
      [else
       (let loop ([start 0])
         (if (= start n)
             (+ 1 (solve (+ mask 1)))
             (if (zero? (bitwise-and mask (expt 2 start)))
                 (let ([current-time (list-ref tasks start)])
                   (let inner-loop ([next (+ start 1)] [new-mask mask] [remaining-time (- session-time current-time)])
                     (cond
                       [(< remaining-time 0)
                        (+ 1 (solve (bitwise-ior mask (expt 2 start))))]
                       [(>= next n)
                        (+ 1 (solve (bitwise-ior mask (expt 2 start))))]
                       [else
                        (if (zero? (bitwise-and new-mask (expt 2 next)))
                            (if (>= remaining-time (list-ref tasks next))
                                (let ([new-new-mask (bitwise-ior new-mask (expt 2 next))])
                                  (min (+ 1 (solve (bitwise-ior mask (expt 2 start))))
                                       (inner-loop (+ next 1) new-new-mask (- remaining-time (list-ref tasks next)))))
                                (inner-loop (+ next 1) new-mask remaining-time))
                            (inner-loop (+ next 1) new-mask remaining-time))])))
                 (loop (+ start 1))))))))
  (solve 0))