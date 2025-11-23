(define (max-possible-number nums)
  (define (compare a b)
    (string>? (string-append a b) (string-append b a)))

  (define sorted-nums (sort (map number->string nums) compare))

  (string->number (string-join sorted-nums "")))