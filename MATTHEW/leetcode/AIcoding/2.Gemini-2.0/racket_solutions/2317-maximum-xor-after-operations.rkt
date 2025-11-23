(define (maximum-xor nums)
  (let loop ([nums nums] [result 0])
    (if (null? nums)
        result
        (loop (cdr nums) (bitwise-ior result (car nums))))))