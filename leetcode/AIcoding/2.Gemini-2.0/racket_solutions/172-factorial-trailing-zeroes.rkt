(define (trailing-zeroes n)
  (let loop ([n n] [count 0])
    (if (< n 5)
        count
        (loop (quotient n 5) (+ count (quotient n 5))))))