(define (reverse-bits n)
  (define (reverse-helper n result)
    (if (= n 0)
        result
        (reverse-helper (ash n -1) (ior (ash result 1) (bitwise-and n 1)))))
  (reverse-helper n 0))

(define (reverseBits n)
  (reverse-bits n))