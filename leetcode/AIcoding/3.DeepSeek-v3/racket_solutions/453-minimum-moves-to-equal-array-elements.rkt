(define/contract (min-moves nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([min-num (apply min nums)]
         [sum (apply + nums)]
         [n (length nums)])
    (- sum (* min-num n))))