(define (increasingTriplet nums)
  (define (helper nums first second)
    (cond
      [(empty? nums) #f]
      [(< (first nums) first) (helper (rest nums) (first nums) second)]
      [(and (> (first nums) first) (< (first nums) second)) (helper (rest nums) first (first nums))]
      [(> (first nums) second) #t]
      [else (helper (rest nums) first second)]))
  (if (< (length nums) 3)
      #f
      (helper (rest nums) (first nums) +inf.0)))