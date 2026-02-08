(define (split-array-same-average nums)
  (let* ([n (length nums)]
         [total (apply + nums)]
         [m (quotient n 2)]
         [possible false])
    (for ([k (in-range 1 (+ m 1))])
      (when (zero? (remainder (* total k) n))
        (set! possible true)))
    (unless possible (return false))
    (let ([dp (make-hash)])
      (hash-set! dp 0 (set 0))
      (for ([num (in-list nums)])
        (let ([new-dp (make-hash)])
          (for ([(sum counts) (in-hash dp)])
            (for ([count (in-set counts)])
              (let ([new-sum (+ sum num)]
                    [new-count (+ count 1)])
                (hash-update! new-dp new-sum 
                              (lambda (s) (set-add s new-count))
                              (set)))))
          (for ([(sum counts) (in-hash new-dp)])
            (hash-update! dp sum 
                          (lambda (s) (set-union s counts))
                          (set)))))
      (for ([k (in-range 1 (+ m 1))])
        (when (zero? (remainder (* total k) n))
          (let ([target (quotient (* total k) n)])
            (when (hash-has-key? dp target)
              (when (set-member? (hash-ref dp target) k)
                (return true)))))
      false)))