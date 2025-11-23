#lang racket

(define (shortest-path-visiting-all-nodes graph)
  (define n (length graph))

  (when (= n 1) 0)

  (define all-visited-mask (- (expt 2 n) 1))

  (define q (list (list) (list)))

  (define (queue-empty?) (and (null? (car q)) (null? (cadr q))))
  (define (queue-enqueue! item)
    (set-car! (cdr q) (cons item (cadr q))))

  (define (queue-dequeue!)
    (when (queue-empty?) (error "dequeue from empty queue"))
    (if (null? (car q))
        (begin
          (set-car! q (reverse (cadr q)))
          (set-car! (cdr q) (list))
          (queue-dequeue!))
        (let ([item (car (car q))])
          (set-car! (car q) (cdr (car q)))
          item)))

  (define visited (make-hash equal?))

  (for ([i (range n)])
    (define initial-mask (expt 2 i))
    (queue-enqueue! (list 0 i initial-mask))
    (hash-set! visited (list i initial-mask) #t))

  (let bfs-loop ()
    (define current-state (queue-dequeue!))
    (define dist (list-ref current-state 0))
    (define u (list-ref current-state 1))
    (define mask (list-ref current-state 2))

    (when (= mask all-visited-mask)
      dist)

    (for ([v (list-ref graph u)])
      (define new-mask (bitwise-ior mask (expt 2 v)))
      (define new-state-key (list v new-mask))

      (unless (hash-has-key? visited new-state-key)
        (hash-set! visited new-state-key #t)
        (queue-enqueue! (list (+ dist 1) v new-mask))))

    (bfs-loop)))