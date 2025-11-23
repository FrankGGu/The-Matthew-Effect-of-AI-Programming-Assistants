(define (construct-minimum-bitwise-array nums)
  (let* ((n (length nums))
         (result (make-vector n 0)))
    (for ((i (in-range n)))
      (vector-set! result i (apply bitwise-and (map (lambda (j) (if (zero? (vector-ref nums j)) 0 (vector-ref nums j))) (in-range n)))))
    (vector->list result)))

(define (minimumBitwiseArray nums)
  (construct-minimum-bitwise-array nums))