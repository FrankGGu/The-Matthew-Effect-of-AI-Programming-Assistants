(define (minimum-one-bit-operations n)
  (if (= n 0)
      0
      (let loop ((n n) (result 0) (sign 1))
        (if (= n 0)
            result
            (let ((msb (integer-length n)))
              (loop (- n (expt 2 (- msb 1)))
                    (+ result (* sign (expt 2 msb)) )
                    (- sign)))))))