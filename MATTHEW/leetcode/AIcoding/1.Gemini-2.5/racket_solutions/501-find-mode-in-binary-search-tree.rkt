#lang racket

(struct TreeNode (val left right))

(define current-val #f)
(define current-count 0)
(define max-count 0)
(define modes '())

(define (inorder-traverse node)
  (when node
    (inorder-traverse (TreeNode-left node))

    (let ((val (TreeNode-val node)))
      (if (and current-val (= val current-val))
          (set! current-count (+ current-count 1))
          (begin
            (set! current-val val)
            (set! current-count 1))))

    (cond
      ((= current-count max-count)
       (set! modes (cons current-val modes)))
      ((> current-count max-count)
       (set! max-count current-count)
       (set! modes (list current-val))))

    (inorder-traverse (TreeNode-right node))))

(define (find-mode root)
  (set! current-val #f)
  (set! current-count 0)
  (set! max-count 0)
  (set! modes '())

  (when root
    (inorder-traverse root))

  (reverse modes))