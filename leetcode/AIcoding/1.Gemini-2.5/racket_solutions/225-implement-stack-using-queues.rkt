#lang racket

(require racket/queue)

(define my-stack%
  (class object%
    (init-field)

    (define q1 (make-queue))
    (define q2 (make-queue))

    (define/public (push x)
      (enqueue! q2 x)
      (let loop ()
        (unless (queue-empty? q1)
          (enqueue! q2 (dequeue! q1))
          (loop)))
      (let ([temp q1])
        (set! q1 q2)
        (set! q2 temp)))

    (define/public (pop)
      (dequeue! q1))

    (define/public (top)
      (queue-front q1))

    (define/public (empty)
      (queue-empty? q1))))