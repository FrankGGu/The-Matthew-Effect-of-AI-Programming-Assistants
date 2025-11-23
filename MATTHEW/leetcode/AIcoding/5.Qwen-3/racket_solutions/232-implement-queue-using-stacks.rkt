#lang racket

(define-struct queue (stack1 stack2))

(define (make-queue) (queue '() '()))

(define (enqueue q x)
  (queue (cons x (queue-stack1 q)) (queue-stack2 q)))

(define (dequeue q)
  (if (null? (queue-stack2 q))
      (let ((new-stack2 (reverse (queue-stack1 q))))
        (queue '() new-stack2))
      q))

(define (peek q)
  (if (null? (queue-stack2 q))
      (car (reverse (queue-stack1 q)))
      (car (queue-stack2 q))))

(define (empty? q)
  (and (null? (queue-stack1 q)) (null? (queue-stack2 q))))