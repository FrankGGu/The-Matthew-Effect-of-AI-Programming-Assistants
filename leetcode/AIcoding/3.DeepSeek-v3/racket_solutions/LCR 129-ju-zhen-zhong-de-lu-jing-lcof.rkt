#lang racket

(define (exist board word)
  (define rows (length board))
  (define cols (if (null? board) 0 (length (car board))))
  (define (dfs i j k)
    (cond
      [(= k (string-length word)) #t]
      [(or (< i 0) (>= i rows) (< j 0) (>= j cols)) #f]
      [(not (char=? (string-ref word k) (list-ref (list-ref board i) j))) #f]
      [else
       (define tmp (list-ref (list-ref board i) j))
       (list-set! (list-ref board i) j #\0)
       (define res (or (dfs (add1 i) j (add1 k))
                       (dfs (sub1 i) j (add1 k))
                       (dfs i (add1 j) (add1 k))
                       (dfs i (sub1 j) (add1 k))))
       (list-set! (list-ref board i) j tmp)
       res]))
  (for/or ([i (in-range rows)])
    (for/or ([j (in-range cols)])
      (dfs i j 0))))