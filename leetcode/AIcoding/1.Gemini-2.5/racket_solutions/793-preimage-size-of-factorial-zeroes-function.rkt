(define (trailing-zeros n)
  (let loop ((num n) (count 0))
    (if (zero? num)
        count
        (loop (quotient num 5) (+ count (quotient num 5))))))

(define (preimage-size-of-factorial-zeroes-function k)
  (let ((x-min
         (let bin-search ((low 0) (high (+ (* 5 k) 5)))
           (if (> low high)
               low
               (let* ((mid (quotient (+ low high) 2))
                      (zeros (trailing-zeros mid)))
                 (if (< zeros k)
                     (bin-search (+ mid 1) high)
                     (bin-search low (- mid 1))))))))
    (if (= (trailing-zeros x-min) k)
        5
        0)))