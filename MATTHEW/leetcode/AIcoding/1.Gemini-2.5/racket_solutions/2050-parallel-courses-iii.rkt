#lang racket

(define-struct queue (in out) #:mutable)

(define (make-queue)
  (make-queue '() '()))

(define (queue-empty? q)
  (and (null? (queue-in q)) (null? (queue-out q))))

(define (enqueue! q item)
  (set-queue-in! q (cons item (queue-in q))))

(define (dequeue! q)
  (when (queue-empty? q)
    (error "dequeue! on empty queue"))
  (when (null? (queue-out q))
    (set-queue-out! q (reverse (queue-in q)))
    (set-queue-in! q '()))
  (define item (car (queue-out q)))
  (set-queue-out! q (cdr (queue-out q)))
  item)

(define (parallel-courses-iii n relations time)
  (define graph (make-vector n '()))
  (define in-degree (make-vector n 0))
  (define dp (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! dp i (list-ref time i)))

  (for-each (lambda (relation)
              (define u (- (list-ref relation 0) 1))
              (define v (- (list-ref relation 1) 1))
              (vector-set! graph u (cons v (vector-ref graph u)))
              (vector-set! in-degree v (+ (vector-ref in-degree v) 1)))
            relations)

  (define q (make-queue))

  (for ([i (in-range n)])
    (when (= (vector-ref in-degree i) 0)
      (enqueue! q i)))

  (while (not (queue-empty? q))
    (define u (dequeue! q))

    (for-each (lambda (v)
                (vector-set! dp v (max (vector-ref dp v)
                                       (+ (vector-ref dp u) (list-ref time v))))
                (vector-set! in-degree v (- (vector-ref in-degree v) 1))
                (when (= (vector-ref in-degree v) 0)
                  (enqueue! q v)))
              (vector-ref graph u)))

  (define max-time 0)
  (for ([i (in-range n)])
    (set! max-time (max max-time (vector-ref dp i))))
  max-time)