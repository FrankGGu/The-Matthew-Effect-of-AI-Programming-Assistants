#lang racket

(define (time-needed-to-inform-subordinates n headID manager salary)
  (define graph (make-hash))
  (for-each (lambda (i)
              (hash-set! graph i '()))
            (range n))
  (for-each (lambda (i)
              (when (not (= i headID))
                (hash-set! graph (list-ref manager i) (cons i (hash-ref graph (list-ref manager i))))))
            (range n))
  (define (dfs id)
    (if (null? (hash-ref graph id))
        0
        (apply max (map (lambda (i) (+ (dfs i) (list-ref salary i))) (hash-ref graph id)))))
  (dfs headID))