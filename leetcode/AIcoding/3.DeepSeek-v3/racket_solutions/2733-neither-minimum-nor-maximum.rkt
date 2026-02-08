(define/contract (find-non-min-or-max nums)
  (-> (listof exact-integer?) exact-integer?)
  (if (< (length nums) 3)
      -1
      (let ([sorted (sort nums <)])
        (if (or (= (car sorted) (cadr sorted))
            -1
            (cadr sorted)))))