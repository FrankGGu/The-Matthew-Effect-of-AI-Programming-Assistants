(define (break-palindrome palindrome)
  (define n (string-length palindrome))

  (if (= n 1)
      ""
      (let ([chars (string->list palindrome)])
        (let loop ([i 0])
          (if (< i (quotient n 2))
              (if (char=? (list-ref chars i) #\a)
                  (loop (+ i 1))
                  (list->string (list-set chars i #\a)))
              (list->string (list-set chars (- n 1) #\b)))))))