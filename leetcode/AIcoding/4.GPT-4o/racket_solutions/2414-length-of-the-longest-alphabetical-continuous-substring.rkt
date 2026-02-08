(define (longest-continuous-substring s)
  (define len (string-length s))
  (define max-len 0)
  (define current-len 1)

  (for ([i (in-range 1 len)])
    (when (char<? (string-ref s (- i 1)) (string-ref s i))
      (set! current-len (+ current-len 1))
      (set! max-len (max max-len current-len))
      )
    (when (char>=? (string-ref s (- i 1)) (string-ref s i))
      (set! current-len 1)))

  (max max-len current-len))

(longest-continuous-substring "abcdeabcd") ; example usage