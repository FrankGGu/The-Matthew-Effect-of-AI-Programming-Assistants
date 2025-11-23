(define (countBits n)
  (define (count set-bit num)
    (if (= num 0)
        set-bit
        (count (+ set-bit (modulo num 2)) (quotient num 2))))
  (map (lambda (x) (count 0 x)) (range 0 (+ n 1))))