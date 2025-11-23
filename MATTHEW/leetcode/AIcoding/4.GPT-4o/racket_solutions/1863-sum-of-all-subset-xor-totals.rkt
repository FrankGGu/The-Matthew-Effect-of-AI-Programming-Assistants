(define (subsetXORSum nums)
  (define (xor-of-subsets nums current-xor index)
    (if (= index (length nums))
        current-xor
        (+ (xor-of-subsets nums (bitwise-xor current-xor (list-ref nums index)) (+ index 1))
           (xor-of-subsets nums current-xor (+ index 1)))))
  (xor-of-subsets nums 0 0))

(define (sumOfAllSubsetXORTotals nums)
  (subsetXORSum nums))