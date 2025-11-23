(define (bitwise-complement n)
  (if (= n 0)
      1
      (let loop ((mask 1) (val n))
        (if (<= mask val)
            (loop (+ (* mask 2) 1) val)
            (- mask n)))))