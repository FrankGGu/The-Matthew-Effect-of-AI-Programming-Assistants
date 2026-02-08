(define (is-good nums)
  (let* ([n (sub1 (length nums))]
         [sorted (sort nums <)]
         [base (take (range 1 (+ n 1)) n)])
    (and (equal? (take sorted n) base)
         (equal? (list-ref sorted n) n))))