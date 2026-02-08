(define/contract (max-increasing-groups usageLimits)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([sorted (sort usageLimits <)]
             [k 0]
             [required 1])
    (cond
      [(null? sorted) k]
      [(>= (car sorted) required)
       (loop (cdr sorted) (add1 k) (add1 required))]
      [else
       (loop (cdr sorted) k required)])))