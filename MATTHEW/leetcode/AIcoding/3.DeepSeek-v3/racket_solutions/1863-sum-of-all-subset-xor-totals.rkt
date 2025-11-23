(define (subset-xor-sum nums)
  (define (helper index current-xor)
    (if (= index (length nums))
        current-xor
        (+ (helper (+ index 1) current-xor)
                  (helper (+ index 1) (bitwise-xor current-xor (list-ref nums index))))))
  (helper 0 0))