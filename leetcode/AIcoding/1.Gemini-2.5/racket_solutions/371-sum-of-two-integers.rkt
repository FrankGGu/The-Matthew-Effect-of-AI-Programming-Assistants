(define (get-sum a b)
  (let loop ((x a) (y b))
    (if (= y 0)
        x
        (loop (bitwise-xor x y)
              (arithmetic-shift (bitwise-and x y) 1)))))