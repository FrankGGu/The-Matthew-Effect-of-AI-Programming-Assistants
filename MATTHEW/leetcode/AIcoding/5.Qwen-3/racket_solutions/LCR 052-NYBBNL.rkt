#lang racket

(define (increasing-bst root)
  (define (inorder node)
    (if (not node)
        '()
        (append (inorder (node-left node))
                (list node)
                (inorder (node-right node)))))
  (define (build-tree nodes)
    (if (null? nodes)
        #f
        (let ([new-node (make-object (class* object% () (super-new) (init-field [val (object->value (car nodes))])))]
              [rest (cdr nodes)])
          (set-object-right! new-node (build-tree rest))
          new-node)))
  (build-tree (inorder root)))