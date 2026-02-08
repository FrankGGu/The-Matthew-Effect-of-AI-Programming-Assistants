(define (hammingWeight n)
  (define (count-ones n count)
    (if (= n 0)
        count
        (count-ones (bitwise-arithmetic-shift-right n 1) (+ count (bitwise-and n 1)))))
  (count-ones n 0))