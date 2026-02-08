(define/contract (array-sign nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [sign 1])
    (cond
      [(null? nums) sign]
      [(= (car nums) 0) 0]
      [else (loop (cdr nums) (* sign (if (> (car nums) 0) 1 -1)))])))