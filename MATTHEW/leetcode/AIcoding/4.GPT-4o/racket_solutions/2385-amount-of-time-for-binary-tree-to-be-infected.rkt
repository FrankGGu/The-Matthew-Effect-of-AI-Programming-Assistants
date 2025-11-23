#lang racket

(define-struct TreeNode (val left right))

(define (amountOfTime root start)
  (define (build-graph node graph)
    (when node
      (let ((val (TreeNode-val node)))
        (hash-set! graph val '())
        (when (TreeNode-left node)
          (hash-set! graph val (cons (TreeNode-val (TreeNode-left node)) (hash-ref graph val)))
          (build-graph (TreeNode-left node) graph))
        (when (TreeNode-right node)
          (hash-set! graph val (cons (TreeNode-val (TreeNode-right node)) (hash-ref graph val)))
          (build-graph (TreeNode-right node) graph)))))

  (define (add-edges node graph)
    (when node
      (when (TreeNode-left node)
        (hash-set! graph (TreeNode-val node) (cons (TreeNode-val (TreeNode-left node)) (hash-ref graph (TreeNode-val node))))
        (hash-set! graph (TreeNode-val (TreeNode-left node)) (cons (TreeNode-val node) (hash-ref graph (TreeNode-val (TreeNode-left node))))))
        (add-edges (TreeNode-left node) graph))
      (when (TreeNode-right node)
        (hash-set! graph (TreeNode-val node) (cons (TreeNode-val (TreeNode-right node)) (hash-ref graph (TreeNode-val node))))
        (hash-set! graph (TreeNode-val (TreeNode-right node)) (cons (TreeNode-val node) (hash-ref graph (TreeNode-val (TreeNode-right node))))))
        (add-edges (TreeNode-right node) graph))))

  (define (bfs graph start)
    (define queue (list start))
    (define visited (make-hash))
    (hash-set! visited start 0)
    (define max-time 0)

    (while (not (null? queue))
      (define current (car queue))
      (define time (hash-ref visited current))
      (set! max-time (max max-time time))
      (set! queue (cdr queue))
      (for-each (lambda (neighbor)
                    (unless (hash-has? visited neighbor)
                      (hash-set! visited neighbor (+ time 1))
                      (set! queue (append queue (list neighbor)))))
                  (hash-ref graph current)))
    max-time)

  (define graph (make-hash))
  (build-graph root graph)
  (add-edges root graph)
  (bfs graph start))