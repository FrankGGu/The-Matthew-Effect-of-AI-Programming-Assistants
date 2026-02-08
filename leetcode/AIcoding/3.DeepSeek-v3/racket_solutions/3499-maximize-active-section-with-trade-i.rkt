(define/contract (max-active-sections nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [current 0] [max-active 0])
    (if (null? nums)
        max-active
        (let* ([num (car nums)]
               [new-current (if (> num 0) (add1 current) 0)]
               [new-max (max max-active new-current)])
          (loop (cdr nums) new-current new-max)))))