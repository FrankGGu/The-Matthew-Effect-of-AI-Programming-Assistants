(define (racecar target)
  (let* ([dp (make-hash)]
         [helper (lambda (t)
                   (cond
                     [(hash-has-key? dp t) (hash-ref dp t)]
                     [else
                      (let* ([n (floor (log (+ t 1) 2))]
                             [pos (expt 2 n)]
                             [steps (+ n 1)])
                        (if (= pos t)
                            (begin
                              (hash-set! dp t steps)
                              steps)
                            (let ([res (+ steps 1 (helper (- pos t 1)))])
                              (for ([i (in-range 0 n)])
                                (let* ([new-pos (- pos (expt 2 i))]
                                       [new-steps (+ steps 1 i 1 (helper (- t new-pos)))]
                                       [res (min res new-steps)]))
                                (hash-set! dp t res)
                                res)))))]))])
    (helper target)))