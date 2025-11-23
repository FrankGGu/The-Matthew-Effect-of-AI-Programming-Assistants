(define (number-of-people-aware-of-a-secret n delay forget)
  (define (solve day aware sharing)
    (cond
      [(> day n) (remainder (apply + aware) 1000000007)]
      [else
       (let* ([new-aware (list-ref sharing 0)]
              [new-sharing (drop sharing 1)]
              [new-sharing (if (>= day delay)
                                (append new-sharing (list new-aware))
                                new-sharing)]
              [new-sharing (if (>= day forget)
                                (let ([forget-count (list-ref aware 0)])
                                  (filter (lambda (x) (not (equal? x forget-count))) new-sharing))
                                new-sharing)]
              [new-aware (drop aware 1)]
              [new-aware (append new-aware (list new-aware))]
              )
         (solve (+ day 1) (append new-aware (list new-aware)) new-sharing))]))
  (solve 1 '(1) '()))