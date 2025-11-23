(define (number-ways hats)
  (define n (length hats))
  (define hat-to-people (make-hash))
  (for/list ([i (in-range n)])
    (for/list ([hat (in-list (list-ref hats i))])
      (hash-update! hat-to-people hat (lambda (xs) (cons i xs)) '())))
  (define all-masks (expt 2 n))
  (define memo (make-hash))
  (define (dp hat mask)
    (cond
      [(= mask all-masks) 1]
      [(= hat 41) 0]
      [(hash-has-key? memo (cons hat mask)) (hash-ref memo (cons hat mask))]
      [else
       (define ways (dp (+ hat 1) mask))
       (when (hash-has-key? hat-to-people hat)
         (for ([person (in-list (hash-ref hat-to-people hat))])
           (when (zero? (bitwise-and mask (expt 2 person)))
             (set! ways (+ ways (dp (+ hat 1) (bitwise-ior mask (expt 2 person))))))))
       (hash-set! memo (cons hat mask) (modulo ways 1000000007))
       (modulo ways 1000000007)]))
  (dp 1 0))