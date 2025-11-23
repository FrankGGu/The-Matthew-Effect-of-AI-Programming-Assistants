(define (single-number nums)
  (let loop ([i 0] [ones 0] [twos 0])
    (if (= i (length nums))
        ones
        (let ([num (list-ref nums i)])
          (let ([new-ones (bitwise-xor ones num)]
                [new-twos (bitwise-ior (bitwise-and (bitwise-not ones) (bitwise-and twos num))
                                      (bitwise-and (bitwise-not twos) (bitwise-and ones num)))])
            (loop (+ i 1) new-ones new-twos))))))