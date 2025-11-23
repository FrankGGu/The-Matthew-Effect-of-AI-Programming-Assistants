(define (min-diff-in-bst root)
  (let ((values (list)))
    (define (inorder node)
      (cond [(null? node) void]
            [else
             (inorder (bst-node-left node))
             (set! values (append values (list (bst-node-val node))))
             (inorder (bst-node-right node))]))
    (inorder root)
    (let loop ((lst (cdr values)) (prev (car values)) (min-diff +inf.0))
      (cond [(null? lst) min-diff]
            [else (loop (cdr lst) (car lst) (min min-diff (- (car lst) prev)))]))))