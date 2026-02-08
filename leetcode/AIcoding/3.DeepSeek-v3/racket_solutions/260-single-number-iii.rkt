(define/contract (single-number nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([xor-sum (foldl bitwise-xor 0 nums)]
         [diff-bit (bitwise-and xor-sum (- xor-sum))]
         [num1 0]
         [num2 0])
    (for ([num nums])
      (if (zero? (bitwise-and num diff-bit))
          (set! num1 (bitwise-xor num1 num))
          (set! num2 (bitwise-xor num2 num))))
    (list num1 num2)))