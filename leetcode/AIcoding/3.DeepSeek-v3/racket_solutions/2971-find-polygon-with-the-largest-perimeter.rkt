(define/contract (largest-perimeter nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums (sort nums <)]
             [sum 0]
             [ans -1])
    (if (null? nums)
        (if (>= ans 0) ans -1)
        (let ([current (car nums)]
              [rest (cdr nums)])
          (if (and (> sum current) (not (null? rest)))
              (loop rest (+ sum current) (+ sum current))
              (loop rest (+ sum current) ans))))))