(define/contract (find-mode root)
  (-> (or/c null? TreeNode?) (listof exact-integer?))
  (define max-count 0)
  (define current-val null)
  (define current-count 0)
  (define modes '())

  (define (inorder node)
    (when node
      (inorder (TreeNode-left node))
      (if (equal? current-val (TreeNode-val node))
          (set! current-count (add1 current-count))
          (begin
            (set! current-val (TreeNode-val node))
            (set! current-count 1)))
      (cond
        [(> current-count max-count)
         (set! max-count current-count)
         (set! modes (list current-val))]
        [(= current-count max-count)
         (set! modes (cons current-val modes))])
      (inorder (TreeNode-right node))))

  (inorder root)
  (reverse modes))