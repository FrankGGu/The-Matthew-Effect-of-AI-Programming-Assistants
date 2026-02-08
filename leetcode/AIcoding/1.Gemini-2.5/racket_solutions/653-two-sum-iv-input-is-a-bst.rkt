#lang racket

(struct TreeNode (val left right))

(define (find-target root k)
  (define seen-values (make-hash))

  (define (dfs node)
    (cond
      [(not node) #f]
      [else
       (define current-val (TreeNode-val node))
       (define complement (- k current-val))

       (if (hash-has-key? seen-values complement)
           #t
           (begin
             (hash-set! seen-values current-val #t)
             (or (dfs (TreeNode-left node))
                 (dfs (TreeNode-right node)))))]))

  (dfs root))