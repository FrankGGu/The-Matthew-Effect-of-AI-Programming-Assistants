(define (shortest-palindrome s)
  (define (is-palindrome str)
    (equal? str (string-reverse str)))

  (define (find-shortest-palindrome s)
    (for/fold ([longest 0]) ([i (in-range (string-length s))])
      (if (is-palindrome (substring s 0 i))
          (max longest i)
          longest))
    )

  (define longest-palindrome-index (find-shortest-palindrome s))
  (define suffix (substring s longest-palindrome-index))
  (define prefix (string-reverse suffix))
  (string-append prefix s))

(shortest-palindrome "aacecaaa")