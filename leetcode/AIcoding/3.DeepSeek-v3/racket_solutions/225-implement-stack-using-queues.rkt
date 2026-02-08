#lang racket

(define stack%
  (class object%
    (super-new)
    (init-field)
    (define q1 (make-queue))
    (define q2 (make-queue))

    (define/public (push x)
      (enqueue! q2 x)
      (let loop ()
        (unless (queue-empty? q1)
          (enqueue! q2 (dequeue! q1))
          (loop)))
      (set! q1 q2)
      (set! q2 (make-queue)))

    (define/public (pop)
      (dequeue! q1))

    (define/public (top)
      (queue-front q1))

    (define/public (empty)
      (queue-empty? q1))))