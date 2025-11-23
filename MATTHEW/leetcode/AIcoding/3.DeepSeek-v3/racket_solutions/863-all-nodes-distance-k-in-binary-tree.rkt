#lang racket

(provide distanceK)

(define (distanceK root target k)
  (define parent (make-hash))
  (define (build-parent node p)
    (when node
      (hash-set! parent node p)
      (build-parent (node-left node) node)
      (build-parent (node-right node) node)))

  (build-parent root #f)

  (define visited (mutable-set))
  (define result '())
  (define q (make-queue))

  (enqueue! q target)
  (set-add! visited target)
  (define level 0)

  (let loop ()
    (unless (queue-empty? q)
      (define size (queue-length q))
      (when (= level k)
        (for ([i (in-range size)])
          (define node (dequeue! q))
          (set! result (cons (node-val node) result)))
        (loop))
      (when (< level k)
        (for ([i (in-range size)])
          (define node (dequeue! q))
          (for ([neighbor (list (node-left node) (node-right node) (hash-ref parent node #f))])
            (when (and neighbor (not (set-member? visited neighbor)))
              (set-add! visited neighbor)
              (enqueue! q neighbor)))
        (set! level (add1 level))
        (loop))))
  (reverse result))

(define-struct node (val left right) #:transparent)