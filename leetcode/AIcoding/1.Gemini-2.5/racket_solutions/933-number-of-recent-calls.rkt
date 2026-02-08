#lang racket

(require data/queue)

(struct recent-counter (q) #:mutable)

(define (recent-counter-new)
  (recent-counter (make-queue)))

(define (recent-counter-ping self t)
  (let ([q (recent-counter-q self)])
    (enqueue! q t)
    (let loop ()
      (when (and (not (queue-empty? q))
                 (< (queue-front q) (- t 3000)))
        (dequeue! q)
        (loop)))
    (queue-length q)))