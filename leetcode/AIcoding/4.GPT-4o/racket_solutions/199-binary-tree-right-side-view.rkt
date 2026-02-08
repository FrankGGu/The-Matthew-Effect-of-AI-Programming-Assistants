(define (rightSideView root)
  (define (dfs node level result)
    (if (null? node)
        result
        (begin
          (if (< level (length result))
              result
              (set! result (append result (list (node-value node)))))
          (dfs (right node) (+ level 1) result)
          (dfs (left node) (+ level 1) result))))
  (dfs root 0 '()))