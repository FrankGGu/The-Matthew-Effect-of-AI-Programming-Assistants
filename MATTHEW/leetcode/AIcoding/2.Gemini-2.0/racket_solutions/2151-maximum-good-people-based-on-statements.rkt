(define (maximum-good-people statements)
  (let* ((n (length statements))
         (max-good 0))
    (for ([i (in-range (expt 2 n))])
      (let loop ([person 0]
                 [good-count 0]
                 [consistent? #t])
        (cond
          [(equal? person n)
           (when consistent?
             (set! max-good (max max-good good-count)))]
          [else
           (let* ([is-good? (bitwise-bit-set? i person)])
             (if is-good?
                 (loop (+ person 1) (+ good-count 1) consistent?)
                 (let next-person-loop ([statement-person 0])
                   (cond
                     [(equal? statement-person n)
                      (loop (+ person 1) good-count consistent?)]
                     [else
                      (let* ([statement (list-ref (list-ref statements person) statement-person)])
                        (cond
                          [(equal? statement 2)
                           (next-person-loop (+ statement-person 1))]
                          [(equal? statement 1)
                           (if (bitwise-bit-set? i statement-person)
                               (next-person-loop (+ statement-person 1))
                               (loop n 0 #f))]
                          [(equal? statement 0)
                           (if (not (bitwise-bit-set? i statement-person))
                               (next-person-loop (+ statement-person 1))
                               (loop n 0 #f))]
                          [else
                           (error "Invalid statement value")]))]))]))]))))
    max-good))