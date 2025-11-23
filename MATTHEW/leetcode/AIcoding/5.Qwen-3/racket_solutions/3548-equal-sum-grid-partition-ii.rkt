#lang racket

(define (can-partition grid)
  (define (sum-row r) (apply + (vector-ref grid r)))
  (define (sum-col c) (apply + (map (lambda (row) (vector-ref row c)) grid)))
  (define rows (length grid))
  (define cols (length (vector-ref grid 0)))
  (define total (apply + (map sum-row (range rows))))
  (if (odd? total) #f
      (let ((target (/ total 2)))
        (define (dfs i s)
          (cond [(= s target) #t]
                [(>= i rows) #f]
                [else (or (dfs (+ i 1) s)
                          (and (<= (+ s (sum-row i)) target)
                               (dfs (+ i 1) (+ s (sum-row i)))))]))
        (dfs 0 0))))