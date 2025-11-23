#lang racket

(define (exist board word)
  (define rows (length board))
  (define cols (length (car board)))
  (define visited (make-vector rows (make-vector cols #f)))

  (define (dfs i j k)
    (cond
      [(>= k (string-length word)) #t]
      [(or (< i 0) (>= i rows) (< j 0) (>= j cols)) #f]
      [(vector-ref (vector-ref visited i) j) #f]
      [(not (char=? (string-ref word k) (string-ref (vector-ref board i) j))) #f]
      [else
       (vector-set! (vector-ref visited i) j #t)
       (let ([res (or (dfs (add1 i) j (add1 k))
                      (dfs (sub1 i) j (add1 k))
                      (dfs i (add1 j) (add1 k))
                      (dfs i (sub1 j) (add1 k)))])
         (vector-set! (vector-ref visited i) j #f)
         res)]))

  (for*/or ([i (in-range rows)]
            [j (in-range cols)]
            #:when (char=? (string-ref word 0) (string-ref (vector-ref board i) j)))
    (dfs i j 0)))