(define (is-palindrome s)
  (equal? s (string-reverse s)))

(define (backtrack s start path result)
  (if (= start (string-length s))
    (begin
      (set! result (cons path result))
      )
    (for ([end (in-range start (+ start 1 (string-length s)))])
      (let ([substr (substring s start end)])
        (when (is-palindrome substr)
          (backtrack s end (cons substr path) result))))))

(define (partition s)
  (let ([result '()])
    (backtrack s 0 '() result)
    (reverse result)))

(partition "aab")