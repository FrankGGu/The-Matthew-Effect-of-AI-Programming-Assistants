#lang racket

(struct TreeNode (val left right))

(define (min-camera-cover root)
  (define cameras 0)

  (define (dfs node)
    (cond
      ((null? node) 1)
      (else
       (define l-state (dfs (TreeNode-left node)))
       (define r-state (dfs (TreeNode-right node)))

       (cond
         ((or (= l-state 0) (= r-state 0))
          (set! cameras (+ cameras 1))
          2)
         ((or (= l-state 2) (= r-state 2))
          1)
         (else
          0))))
    )

  (define root-state (dfs root))

  (if (= root-state 0)
      (+ cameras 1)
      cameras))