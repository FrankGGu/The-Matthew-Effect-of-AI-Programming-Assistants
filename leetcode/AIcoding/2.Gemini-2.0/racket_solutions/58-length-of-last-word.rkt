(define (length-of-last-word s)
  (let* ([trimmed-s (string-trim s)]
         [words (string-split trimmed-s)])
    (if (null? words)
        0
        (string-length (last words)))))