(define (subsets nums)
  (define (backtrack start path)
    (cons path
          (for/fold ([res '()])
                    ([i (in-range start (length nums))])
            (append res (backtrack (+ i 1) (cons (list-ref nums i) path))))))
  (backtrack 0 '()))