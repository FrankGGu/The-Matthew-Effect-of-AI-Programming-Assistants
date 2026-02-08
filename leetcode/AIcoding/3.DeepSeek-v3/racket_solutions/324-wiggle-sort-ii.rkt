(define/contract (wiggle-sort nums)
  (-> (listof exact-integer?) void?)
  (let* ([sorted (sort nums <)]
         [n (length nums)]
         [mid (quotient (sub1 n) 2)]
         [left (reverse (take sorted (add1 mid)))]
         [right (drop sorted (add1 mid))])
    (let loop ([i 0] [left left] [right right])
      (when (< i n)
        (if (even? i)
            (begin
              (list-set! nums i (car left))
              (loop (add1 i) (cdr left) right))
            (begin
              (list-set! nums i (car right))
              (loop (add1 i) left (cdr right))))))))