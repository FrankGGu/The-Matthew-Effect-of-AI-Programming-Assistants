#lang racket

(define (min-reorder n connections)
  (define graph (make-vector n '()))
  (define reverse-count 0)

  (for ([edge connections])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! graph u (cons (cons v 0) (vector-ref graph u)))
      (vector-set! graph v (cons (cons u 1) (vector-ref graph v)))))

  (define visited (make-vector n #f))
  (define q (make-queue))

  (enqueue! q 0)
  (vector-set! visited 0 #t)

  (let loop ()
    (unless (queue-empty? q)
      (let ([u (dequeue! q)])
        (for ([neighbor (vector-ref graph u)])
          (let ([v (car neighbor)]
                [cost (cdr neighbor)])
            (unless (vector-ref visited v)
              (vector-set! visited v #t)
              (set! reverse-count (+ reverse-count cost))
              (enqueue! q v))))
        (loop))))

  reverse-count)

(define (make-queue) (mcons '() '()))
(define (enqueue! q x)
  (if (null? (mcar q))
      (let ([new-pair (mcons x '())])
        (set-mcar! q new-pair)
        (set-mcdr! q new-pair))
      (let ([new-pair (mcons x '())])
        (set-mcdr! (mcdr q) new-pair)
        (set-mcdr! q new-pair))))
(define (dequeue! q)
  (let ([front (mcar q)])
    (set-mcar! q (mcdr front))
    (when (null? (mcar q)) (set-mcdr! q '()))
    (mcar front)))
(define (queue-empty? q) (null? (mcar q)))