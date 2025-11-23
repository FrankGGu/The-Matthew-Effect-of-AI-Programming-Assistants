(define/contract (min-subsequence nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([sorted (sort nums >)]
         [total (apply + nums)]
         [half (quotient total 2)]
         [result (let loop ([rest sorted]
                          [sum 0]
                          [acc '()])
                   (if (> sum half)
                       (reverse acc)
                       (loop (cdr rest)
                             (+ sum (car rest))
                             (cons (car rest) acc))))])
    result))