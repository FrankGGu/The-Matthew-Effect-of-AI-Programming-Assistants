(define/contract (remove-duplicates nums)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? nums)
      0
      (let loop ([prev (car nums)]
                 [rest (cdr nums)]
                 [k 1])
        (if (null? rest)
            k
            (if (= prev (car rest))
                (loop prev (cdr rest) k)
                (begin
                  (list-set! nums k (car rest))
                  (loop (car rest) (cdr rest) (add1 k))))))))