#lang racket

(define (calcEquation equations values queries)
  (define graph (make-hash))

  (for ([eq equations] [val values])
    (let ([u (car eq)] [v (cadr eq)])
      (hash-update! graph u (lambda (lst) (cons (cons v val) lst)) '())
      (hash-update! graph v (lambda (lst) (cons (cons u (/ 1 val)) lst)) '())))

  (define (bfs start end)
    (unless (and (hash-has-key? graph start) (hash-has-key? graph end))
      (return -1.0))
    (define visited (make-hash))
    (hash-set! visited start #t)
    (define queue (make-queue))
    (enqueue! queue (cons start 1.0))

    (let loop ()
      (if (queue-empty? queue)
          -1.0
          (let* ([node (dequeue! queue)]
                 [curr (car node)]
                 [curr-val (cdr node)])
            (if (equal? curr end)
                curr-val
                (begin
                  (for ([neighbor (hash-ref graph curr '())])
                    (let ([next (car neighbor)]
                          [next-val (cdr neighbor)])
                      (unless (hash-has-key? visited next)
                        (hash-set! visited next #t)
                        (enqueue! queue (cons next (* curr-val next-val)))))
                  (loop)))))))

  (map bfs (map car queries) (map cadr queries)))

(define (make-queue) (mcons null null))
(define (enqueue! q x)
  (if (null? (mcar q))
      (begin (set-mcar! q (list x)) (set-mcdr! q (mcar q)))
      (begin (set-mcdr! (mcdr q) (list x)) (set-mcdr! q (mcdr (mcdr q))))))
(define (dequeue! q)
  (let ([x (car (mcar q))])
    (set-mcar! q (cdr (mcar q)))
    (when (null? (mcar q)) (set-mcdr! q null))
    x))
(define (queue-empty? q) (null? (mcar q)))