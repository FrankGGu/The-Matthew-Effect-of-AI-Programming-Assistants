(define (trailing-zeroes n)
  (let loop ((num n) (count 0))
    (if (<= num 0)
        count
        (loop (quotient num 5) (+ count (quotient num 5))))))