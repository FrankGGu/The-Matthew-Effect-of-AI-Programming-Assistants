(define (hasPathSum root sum)
  (cond
    [(null? root) (= sum 0)]
    [(and (null? (tree-left root)) (null? (tree-right root))) (= sum (tree-val root))]
    [else (or (hasPathSum (tree-left root) (- sum (tree-val root)))
              (hasPathSum (tree-right root) (- sum (tree-val root))))]))

(define (tree-val node) (if node (car node) 0))
(define (tree-left node) (if node (cadr node) '()))
(define (tree-right node) (if node (caddr node) '()))