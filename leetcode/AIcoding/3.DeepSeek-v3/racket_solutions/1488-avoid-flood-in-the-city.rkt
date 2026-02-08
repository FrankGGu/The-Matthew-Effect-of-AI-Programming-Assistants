(define/contract (avoid-flood rains)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define lake-days (make-hash))
  (define dry-days (mutable-set))
  (define result '())
  (for ([day (in-naturals)]
        [rain (in-list rains)])
    (if (zero? rain)
        (set-add! dry-days day)
        (let ([prev-day (hash-ref lake-days rain #f)])
          (if prev-day
              (let ([dry-day (for/first ([d (in-set dry-days)]
                                        #:when (> d prev-day))
                              d)])
                (if dry-day
                    (begin
                      (set-remove! dry-days dry-day)
                      (hash-set! lake-days rain day)
                      (set! result (cons -1 result)))
                    (begin
                      (set! result '())
                      (return))))
              (begin
                (hash-set! lake-days rain day)
                (set! result (cons -1 result))))))
  (if (null? result)
      '()
      (reverse result)))