(define (rangeBitwiseAnd m n)
  (if (= m n)
      m
      (let loop ((m m) (n n) (shift 0))
        (if (not (= m n))
            (loop (bitwise-arithmetic-shift-right m 1)
                  (bitwise-arithmetic-shift-right n 1)
                  (+ shift 1))
            (bitwise-arithmetic-shift-left m shift)))))

(require racket/unsafe/ops)