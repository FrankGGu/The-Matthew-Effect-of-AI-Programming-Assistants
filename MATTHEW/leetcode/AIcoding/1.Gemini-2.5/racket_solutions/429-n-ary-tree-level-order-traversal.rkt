#lang racket

(require racket/queue)

(define (levelOrder root)
  (define result '())
  (when root
    (define q (make-queue))
    (enqueue! q root)

    (let loop ()
      (unless (queue-empty? q)
        (define level-size (queue-count q))
        (define current-level-nodes-rev '())

        (for ([i (in-range level-size)])
          (define node (dequeue! q))
          (set! current-level-nodes-rev (cons (Node-val node) current-level-nodes-rev))

          (for ([child (Node-children node)])
            (enqueue! q child)))

        (set! result (append result (list (reverse current-level-nodes-rev))))
        (loop))))
  result)