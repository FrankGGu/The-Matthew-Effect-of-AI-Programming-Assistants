(define/contract (find-maximum-length nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [prev -inf.0] [len 0] [res 0])
    (if (null? nums)
        res
        (let* ([x (car nums)]
               [new-len (if (>= x prev) (add1 len) 1)]
               [new-res (max res new-len)])
          (loop (cdr nums) x new-len new-res)))))