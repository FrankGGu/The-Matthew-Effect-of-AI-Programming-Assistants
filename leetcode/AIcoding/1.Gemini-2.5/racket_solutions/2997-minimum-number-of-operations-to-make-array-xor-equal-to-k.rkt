(require racket/bitwise)

(define (min-operations-to-make-array-xor-equal-to-k nums k)
  (let* ((current-xor-sum (foldl bitwise-xor 0 nums))
         (diff-xor (bitwise-xor current-xor-sum k)))
    (bitwise-bit-count diff-xor)))