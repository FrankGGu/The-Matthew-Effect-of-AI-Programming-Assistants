(define (make-the-integer-zero num1 num2)
  (let loop ([count 0] [n num1])
    (cond
      [(= n 0) count]
      [(< n 0) -1]
      [else
       (let ([bits (integer-length n)])
         (if (and (<= 1 num2) (<= num2 bits))
             (loop (+ count 1) (- n (expt 2 (- bits 1))))
             -1))])))