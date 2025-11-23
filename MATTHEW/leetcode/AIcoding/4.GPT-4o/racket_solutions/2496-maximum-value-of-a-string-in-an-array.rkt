(define (maximumValue strs)
  (define (is-number? s)
    (and (not (string=? s ""))
         (string->number s)))
  (define (max-value acc s)
    (if (is-number? s)
        (max acc (string->number s))
        (max acc (string-length s))))
  (foldl max-value 0 strs))

(maximumValue '("123" "4" "56" "abc" "1a2")) ; should return 123