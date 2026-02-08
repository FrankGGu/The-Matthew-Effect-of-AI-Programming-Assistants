#lang racket

(define (buildTree inorder postorder)
  (if (null? inorder)
      '()
      (let* ((root-val (last postorder))
             (root-pos (index-of inorder root-val))
        (cons root-val
              (cons (buildTree (take inorder root-pos) (take postorder root-pos))
                    (buildTree (drop inorder (add1 root-pos)) (take postorder root-pos))))))))