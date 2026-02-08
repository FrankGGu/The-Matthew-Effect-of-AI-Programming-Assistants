(define (OnlineMajorityElement)
  (define counts (make-hash))
  (define total 0)

  (define (add num)
    (hash-set! counts num (add1 (hash-ref counts num 0)))
    (set! total (add1 total)))

  (define (remove num)
    (hash-set! counts num (sub1 (hash-ref counts num 1)))
    (set! total (sub1 total)))

  (define (query)
    (define majority-threshold (/ total 2))
    (for/sum ((k (hash-keys counts)))
      (if (>= (hash-ref counts k) majority-threshold)
          1
          0)))

  (define (majority-element)
    (define majority (for/fold ([res '()]) ((k (hash-keys counts)))
                          (if (>= (hash-ref counts k) (floor (/ total 2)))
                              (cons k res)
                              res)))
    (if (null? majority)
        '()
        (car majority)))

  (define (add-remove-query op num)
    (cond
      [(equal? op 'add) (add num)]
      [(equal? op 'remove) (remove num)]
      [(equal? op 'query) (majority-element)])))

  (lambda (op num)
    (add-remove-query op num)))