(define/contract (length-of-last-word s)
  (-> string? exact-integer?)
  (let* ([trimmed (string-trim s)]
         [words (string-split trimmed)])
    (if (null? words)
        0
        (string-length (last words)))))