(define/contract (zero-filled-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [count 0] [res 0])
    (if (null? nums)
        res
        (if (zero? (car nums))
            (loop (cdr nums) (add1 count) (+ res count 1))
            (loop (cdr nums) 0 res)))))