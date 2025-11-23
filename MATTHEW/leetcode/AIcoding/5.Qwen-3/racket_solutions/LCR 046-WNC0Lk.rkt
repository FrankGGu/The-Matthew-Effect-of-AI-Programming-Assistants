#lang racket

(define-struct: TreeNode ([val : any] [left : (U TreeNode #f)] [right : (U TreeNode #f)]))

(define (right-side-view root)
  (define (bfs queue result)
    (cond [(null? queue) result]
          [else
           (define level-size (length queue))
           (define next-queue '())
           (define last-val #f)
           (for ([i (in-range level-size)])
             (define node (car queue))
             (set! last-val (TreeNode-val node))
             (when (TreeNode-left node) (set! next-queue (cons (TreeNode-left node) next-queue)))
             (when (TreeNode-right node) (set! next-queue (cons (TreeNode-right node) next-queue)))
             (set! queue (cdr queue)))
           (bfs next-queue (append result (list last-val)))]))
  (if (not root) '() (bfs (list root) '())))