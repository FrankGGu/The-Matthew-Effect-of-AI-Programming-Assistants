(define/contract (max-sub-array nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [current-max (car nums)] [global-max (car nums)])
    (if (null? nums)
        global-max
        (let* ([num (car nums)]
               [new-current (max num (+ current-max num))]
               [new-global (max global-max new-current)])
          (loop (cdr nums) new-current new-global)))))