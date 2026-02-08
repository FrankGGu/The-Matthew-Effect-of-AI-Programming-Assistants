(define/contract (special-array nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([x 0])
    (let ([count (length (filter (lambda (n) (>= n x)) nums))])
      (cond
        [(> x (length nums)) -1]
        [(= count x) x]
        [else (loop (add1 x))]))))