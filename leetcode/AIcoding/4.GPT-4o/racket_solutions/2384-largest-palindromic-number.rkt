(define (largest-palindromic-number digits)
  (define (is-palindrome? s)
    (equal? s (string-reverse s)))

  (define (build-palindrome half)
    (let* ((len (string-length half))
           (first-half (substring half 0 len))
           (second-half (string-reverse first-half)))
      (if (even? len)
          (string-append first-half second-half)
          (string-append first-half (substring half len (- len 1)) second-half))))

  (define (find-largest half)
    (let ((palindrome (build-palindrome half)))
      (if (and (not (string=? palindrome "0")) (is-palindrome? palindrome))
          palindrome
          "0")))

  (define (backtrack half)
    (if (string=? half "")
        (find-largest "")
        (for/fold ([best ""]) ([digit (in-range 10)])
          (let ((new-half (string-append half (number->string digit))))
            (if (string=? new-half "0")
                best
                (max best (backtrack new-half)))))))

  (backtrack ""))

(largest-palindromic-number 5)