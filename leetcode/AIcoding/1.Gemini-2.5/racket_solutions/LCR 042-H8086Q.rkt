#lang racket

(require data/queue)

(struct RecentCounter (q) #:mutable)

(define (RecentCounter%)
  (RecentCounter (make-queue)))

(define (RecentCounter-ping rc ts)
  (enqueue! (RecentCounter-q rc) ts)
  (let loop ()
    (when (and (not (queue-empty? (RecentCounter-q rc)))
               (< (queue-front (RecentCounter-q rc)) (- ts 3000)))
      (dequeue! (RecentCounter-q rc))
      (loop)))
  (queue-length (RecentCounter-q rc)))