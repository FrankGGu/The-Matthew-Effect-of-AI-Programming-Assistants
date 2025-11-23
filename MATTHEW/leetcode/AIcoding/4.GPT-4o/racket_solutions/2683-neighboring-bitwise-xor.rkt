(define (neighboringBitwiseXOR nums)
  (let* ((n (length nums))
         (result (make-vector n 0)))
    (for ([i (in-range n)])
      (vector-set! result i
        (bitwise-xor (if (> i 0) (vector-ref nums (- i 1)) 0)
                      (if (< i (- n 1)) (vector-ref nums (+ i 1)) 0))))
    (vector->list result)))