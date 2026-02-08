(define (minimumOperations(nums k)
  (define xor-sum (foldl xor 0 nums))
  (if (= xor-sum k)
      0
      (if (or (member (xor k xor-sum) nums) (= (length nums) 1))
          1
          2))))

(minimumOperations '(1 2 3) 3)