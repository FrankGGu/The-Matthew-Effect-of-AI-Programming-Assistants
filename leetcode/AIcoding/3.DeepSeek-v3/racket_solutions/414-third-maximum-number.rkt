(define/contract (third-max nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums]
             [max1 -inf.0]
             [max2 -inf.0]
             [max3 -inf.0])
    (if (null? nums)
        (if (equal? max3 -inf.0) max1 max3)
        (let ([num (car nums)])
          (cond
            [(> num max1) (loop (cdr nums) num max1 max2)]
            [(and (< num max1) (> num max2)) (loop (cdr nums) max1 num max2)]
            [(and (< num max2) (> num max3)) (loop (cdr nums) max1 max2 num)]
            [else (loop (cdr nums) max1 max2 max3)])))))