(define (is-palindrome s)
  (equal? s (string-reverse s)))

(define (partition s)
  (define (backtrack start path)
    (if (= start (string-length s))
      (list path)
      (for*/list ([end (in-range (+ start 1) (add1 (string-length s)))])
        (let ([substr (substring s start end)])
          (when (is-palindrome substr)
            (backtrack end (cons substr path)))))))
  (reverse (backtrack 0 '())))

(partition "aab")