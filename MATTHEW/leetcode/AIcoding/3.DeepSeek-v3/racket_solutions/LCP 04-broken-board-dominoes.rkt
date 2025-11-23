#lang racket

(define (dominoes board)
  (define m (length board))
  (define n (if (zero? m) 0 (length (car board))))
  (define visited (make-hash))
  (define (dfs i j)
    (cond
      [(or (< i 0) (>= i m) (< j 0) (>= j n)) 0]
      [(equal? (list-ref (list-ref board i) j) 'X) 0]
      [(hash-ref visited (cons i j) #f) 0]
      [else
       (hash-set! visited (cons i j) #t)
       (+ 1 (dfs (add1 i) j) (dfs (sub1 i) j) (dfs i (add1 j)) (dfs i (sub1 j)))]))
  (define total 0)
  (for ([i (in-range m)])
  (for ([j (in-range n)])
    (unless (or (equal? (list-ref (list-ref board i) j) 'X) (hash-ref visited (cons i j) #f))
      (define cnt (dfs i j))
      (set! total (+ total (quotient cnt 2))))
  total)