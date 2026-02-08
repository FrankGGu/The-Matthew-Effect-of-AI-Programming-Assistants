(define (maximum-xor-after-operations nums)
  (let loop ([res 0])
    (if (null? nums)
        res
        (loop (bitwise-ior res (car nums)) (cdr nums)))))