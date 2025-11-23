#lang racket

(struct Node (val children))

(define (level-order root)
  (define (helper queue result)
    (if (null? queue)
        (reverse result)
        (let* ((level-size (length queue))
               (current-level '())
               (next-queue '()))
          (for ([i (in-range level-size)])
            (define node (first queue))
            (set! current-level (cons (Node-val node) current-level))
            (set! next-queue (append next-queue (Node-children node)))
            (set! queue (rest queue)))
          (set! result (cons (reverse current-level) result))
          (helper next-queue result))))

  (helper (if root (list root) '()) '()))