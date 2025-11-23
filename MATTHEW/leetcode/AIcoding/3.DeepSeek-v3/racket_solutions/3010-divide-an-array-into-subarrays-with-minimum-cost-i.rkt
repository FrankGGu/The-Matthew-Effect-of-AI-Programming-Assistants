(define/contract (minimum-cost nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort (cdr nums) <)]
         [sum (+ (car nums) (car sorted) (cadr sorted)]))
    sum))