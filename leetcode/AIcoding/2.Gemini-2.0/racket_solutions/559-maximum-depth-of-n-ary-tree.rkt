(define (max-depth root)
  (cond
    [(null? root) 0]
    [else (+ 1 (apply max (map max-depth (or (hash-ref root 'children #f) '()))))]))