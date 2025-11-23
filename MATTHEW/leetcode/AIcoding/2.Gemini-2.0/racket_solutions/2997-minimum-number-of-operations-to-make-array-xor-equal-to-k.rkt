(define (min-operations nums k)
  (let ((xor-sum (foldl xor 0 nums)))
    (if (= xor-sum k)
        0
        (length nums))))