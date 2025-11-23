(define (sum-even-numbers-after-queries nums queries)
  (define sum-even
    (for/sum ([n nums] #:when (even? n)) n))
  (define (process-query nums query)
    (let ([index (car query)]
          [val (cadr query)])
      (when (even? (list-ref nums index))
        (set! sum-even (- sum-even (list-ref nums index))))
      (list-set nums index (+ (list-ref nums index) val))
      (when (even? (list-ref nums index))
        (set! sum-even (+ sum-even (list-ref nums index))))
      sum-even))
  (for/fold ([result '()]) ([q queries])
    (cons (process-query nums q) result)))