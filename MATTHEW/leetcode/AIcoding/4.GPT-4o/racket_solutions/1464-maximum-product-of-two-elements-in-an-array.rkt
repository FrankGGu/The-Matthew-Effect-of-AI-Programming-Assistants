(define (maxProduct nums)
  (let* ([sorted (sort nums >)]
         [max1 (car sorted)]
         [max2 (cadr sorted)])
    (* (- max1 1) (- max2 1))))