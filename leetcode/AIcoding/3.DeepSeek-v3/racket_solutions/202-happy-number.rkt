(define/contract (is-happy n)
  (-> exact-integer? boolean?)
  (define (sum-of-squares num)
    (let loop ([num num] [sum 0])
      (if (= num 0)
          sum
          (let ([digit (remainder num 10)])
            (loop (quotient num 10) (+ sum (* digit digit)))))))
  (let loop ([n n] [seen (set)])
    (cond
      [(= n 1) #t]
      [(set-member? seen n) #f]
      [else (loop (sum-of-squares n) (set-add seen n))])))