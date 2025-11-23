(define (subset-xor-sum nums)
  (let loop ([nums nums] [current 0])
    (if (null? nums)
        current
        (+ (loop (cdr nums) current)
           (loop (cdr nums) (bitwise-xor current (car nums)))))))