(define (bitwise-complement n)
  (if (= n 0)
      1
      (let loop ((m 1) (p n))
        (if (< p m)
            (- m n)
            (loop (* m 2) p)))))