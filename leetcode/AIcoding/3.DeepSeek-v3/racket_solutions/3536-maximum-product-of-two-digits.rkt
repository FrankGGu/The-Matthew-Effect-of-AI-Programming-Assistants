(define/contract (max-product nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [max1 -inf.0] [max2 -inf.0] [min1 +inf.0] [min2 +inf.0])
    (if (null? nums)
        (max (* max1 max2) (* min1 min2))
        (let ([num (car nums)])
          (cond
            [(> num max1) (loop (cdr nums) num max1 min1 min2)]
            [(> num max2) (loop (cdr nums) max1 num min1 min2)]
            [(< num min1) (loop (cdr nums) max1 max2 num min2)]
            [(< num min2) (loop (cdr nums) max1 max2 min1 num)]
            [else (loop (cdr nums) max1 max2 min1 min2)])))))