(define (largest-number nums)
  (define string-nums (map number->string nums))

  (define sorted-string-nums
    (sort string-nums
          (lambda (a b)
            (string>? (string-append a b) (string-append b a)))))

  (define result (string-join sorted-string-nums ""))

  (if (and (> (string-length result) 1)
           (char=? (string-ref result 0) #\0))
      "0"
      result))