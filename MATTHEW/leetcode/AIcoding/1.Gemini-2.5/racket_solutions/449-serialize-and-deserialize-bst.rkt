(struct TreeNode (val left right))

(define (serialize root)
  (define (preorder node acc)
    (if (null? node)
        (cons "#" acc)
        (preorder (TreeNode-left node)
                  (cons (number->string (TreeNode-val node))
                        (preorder (TreeNode-right node) acc)))))
  (string-join (reverse (preorder root '())) " "))

(define (deserialize data)
  (let ((vals (string-split data " ")))
    (letrec ((idx (box 0))
             (build-tree
               (lambda ()
                 (let ((current-idx (unbox idx)))
                   (if (>= current-idx (length vals))
                       (error "Malformed input: ran out of tokens")
                       (let ((token (list-ref vals current-idx)))
                         (set-box! idx (+ current-idx 1))

                         (if (string=? token "#")
                             null
                             (let ((val (string->number token)))
                               (let ((left-child (build-tree)))
                                 (let ((right-child (build-tree)))
                                   (TreeNode val left-child right-child)))))))))))
      (build-tree))))