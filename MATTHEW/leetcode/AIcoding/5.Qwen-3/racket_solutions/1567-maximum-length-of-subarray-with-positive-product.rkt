(define/contract (max-length-of-subarray-with-positive-product nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [pos 0] [neg 0] [max-len 0])
    (cond
      [(null? nums) max-len]
      [(= (car nums) 0)
       (loop (cdr nums) 0 0 0)]
      [(positive? (car nums))
       (loop (cdr nums) (add1 pos) neg (max max-len (if (> neg 0) (+ pos neg 1) (add1 pos))))]
      [else
       (loop (cdr nums) neg (add1 neg) (max max-len (if (> pos 0) (+ pos neg 1) (add1 neg))))])))