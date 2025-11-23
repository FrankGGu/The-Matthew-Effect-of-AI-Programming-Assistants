(define (dominantIndex nums)
  (define max1 (apply max nums))
  (define max2 (apply max (filter (lambda (x) (not (= x max1))) nums)))
  (if (>= max1 (* 2 max2))
      (index-of nums max1)
      -1))

(define (index-of lst val)
  (for/fold ([i 0]) ([x lst])
    (if (= x val)
        i
        (add1 i))))