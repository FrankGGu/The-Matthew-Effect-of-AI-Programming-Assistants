(define/contract (single-number nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([ones 0] [twos 0] [nums nums])
    (if (null? nums)
        ones
        (let ([num (car nums)])
          (loop (bitwise-xor ones (bitwise-and (bitwise-not twos) num))
                (bitwise-xor twos (bitwise-and (bitwise-not ones) num))
                (cdr nums))))))