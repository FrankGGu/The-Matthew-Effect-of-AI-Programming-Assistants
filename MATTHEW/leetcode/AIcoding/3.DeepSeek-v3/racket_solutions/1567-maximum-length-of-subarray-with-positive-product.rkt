(define/contract (get-max-len nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([nums nums] [pos 0] [neg 0] [max-len 0])
    (if (null? nums)
        max-len
        (let ([num (car nums)])
          (cond
            [(zero? num) (loop (cdr nums) 0 0 max-len)]
            [(positive? num)
             (let ([new-pos (+ pos 1)]
                   [new-neg (if (> neg 0) (+ neg 1) 0)])
             (loop (cdr nums) new-pos new-neg (max max-len new-pos))]
            [else
             (let ([new-pos (if (> neg 0) (+ neg 1) 0)]
                   [new-neg (+ pos 1)])
             (loop (cdr nums) new-pos new-neg (max max-len new-pos))])))))