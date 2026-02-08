#lang racket

(struct TreeNode (val left right) #:transparent)

(define (serialize root)
  (define (dfs node)
    (if (null? node)
        (list "#")
        (cons (number->string (TreeNode-val node))
              (append (dfs (TreeNode-left node))
                      (dfs (TreeNode-right node))))))
  (string-join (dfs root) ","))

(define (deserialize data)
  (define tokens (string-split data ","))
  (define current-index (box 0))

  (define (dfs-deserialize)
    (define idx (unbox current-index))
    (define token (list-ref tokens idx))
    (set-box! current-index (+ idx 1))

    (cond
      ((string=? token "#") null)
      (else
       (define val (string->number token))
       (define left-node (dfs-deserialize))
       (define right-node (dfs-deserialize))
       (TreeNode val left-node right-node)))))

  (dfs-deserialize))