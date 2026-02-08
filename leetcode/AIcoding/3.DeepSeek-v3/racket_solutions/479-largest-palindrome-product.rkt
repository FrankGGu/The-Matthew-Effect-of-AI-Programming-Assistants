(define (largest-palindrome n)
  (define upper (sub1 (expt 10 n)))
  (define lower (expt 10 (sub1 n)))
  (define (palindrome? x)
    (let ([s (number->string x)])
      (equal? s (list->string (reverse (string->list s))))))
  (define max-palindrome 0)
  (for* ([i (in-range upper lower -1)]
         [j (in-range i lower -1)]
         #:break (< (* i j) max-palindrome))
    (let ([product (* i j)])
      (when (and (> product max-palindrome) (palindrome? product))
        (set! max-palindrome product))))
  (modulo max-palindrome 1337))