(define (largestNumber nums)
  (define (compare a b)
    (if (> (string-append a b) (string-append b a))
        -1
        1))
  (define sorted-nums (sort (map number->string nums) compare))
  (define result (apply string-append sorted-nums))
  (if (string=? result "0")
      "0"
      result))

(largestNumber '(10 2)) ; Example usage