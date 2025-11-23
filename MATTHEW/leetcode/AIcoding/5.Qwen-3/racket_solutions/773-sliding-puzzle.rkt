#lang racket

(define (sliding-puzzle board)
  (define target '(1 2 3 4 5 0))
  (define initial (apply append board))
  (define neighbors
    (lambda (state)
      (define pos (index-of state 0))
      (define moves '((1 3) (0 2 4) (1 5) (0 4) (1 3 5) (2 4)))
      (map (lambda (i) (list-set state pos (list-ref state i)) (list-set state i 0))
           (list-ref moves pos))))
  (define (index-of lst x)
    (for/first ([i (in-range (length lst))] #:when (= (list-ref lst i) x)) i))
  (define (list-set lst idx val)
    (append (take lst idx) (list val) (drop lst (+ idx 1))))
  (define (bfs start)
    (define (helper queue visited)
      (cond [(null? queue) #f]
            [else
             (define current (car queue))
             (if (equal? current target) #t
                 (let ([next-states (filter (lambda (s) (not (member s visited))) (neighbors current))])
                   (helper (append (cdr queue) next-states) (cons current visited))))]))
    (helper (list start) '()))
  (if (bfs initial) #t #f))