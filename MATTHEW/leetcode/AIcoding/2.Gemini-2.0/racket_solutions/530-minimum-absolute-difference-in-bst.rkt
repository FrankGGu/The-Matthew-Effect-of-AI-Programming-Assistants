(define (get-minimum-difference root)
  (let* ((nodes (inorder root))
         (diffs (map (lambda (i) (- (list-ref nodes i) (list-ref nodes (- i 1)))) (range 1 (length nodes)))))
    (apply min diffs)))

(define (inorder root)
  (letrec ((helper (lambda (node acc)
                     (if (null? node)
                         acc
                         (helper (bst-node-left node)
                                 (cons (bst-node-val node)
                                       (helper (bst-node-right node) acc)))))))
    (reverse (helper root '()))))