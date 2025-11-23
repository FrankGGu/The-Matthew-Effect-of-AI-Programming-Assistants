(define (superpalindromes-in-range left right)
  (define (palindrome? n)
    (let ((s (number->string n)))
      (equal? s (list->string (reverse (string->list s))))))

  (define (is-super-palindrome? n)
    (let ((sqrt-n (sqrt n)))
      (and (integer? sqrt-n) (palindrome? sqrt-n) (palindrome? n))))

  (define left-n (string->number left))
  (define right-n (string->number right))

  (define (generate-palindromes limit)
    (define palindromes (mutable-set))
    (define (add-palindrome s)
      (let ((n (string->number s)))
        (when (and n (<= n limit))
          (set-add! palindromes n))))

    (for ([i (in-range 1 100000)])
      (let ((s (number->string i)))
        (add-palindrome (string-append s (list->string (reverse (string->list s)))))
        (for ([c (in-range 0 10)])
          (add-palindrome (string-append s (string c) (list->string (reverse (string->list s))))))))

    (set->list palindromes))

  (define candidates (generate-palindromes right-n))
  (define super-palindromes
    (filter (lambda (n) (and (>= n left-n) (is-super-palindrome? n))) candidates))

  (length super-palindromes))