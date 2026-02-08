(define (min-operations nums k)
  (let loop ([xor 0] [nums nums])
    (if (null? nums)
        (bitwise-xor-count xor k)
        (loop (bitwise-xor xor (car nums)) (cdr nums)))))

(define (bitwise-xor-count a b)
  (let ([diff (bitwise-xor a b)])
    (if (zero? diff)
        0
        (+ (bitwise-and diff 1) (bitwise-xor-count (arithmetic-shift diff -1) 0)))))