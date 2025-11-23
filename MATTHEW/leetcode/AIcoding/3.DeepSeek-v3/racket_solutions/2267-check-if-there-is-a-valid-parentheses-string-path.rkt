#lang racket

(define (has-valid-path grid)
  (let* ([m (vector-length grid)]
         [n (if (> m 0) (vector-length (vector-ref grid 0)) 0)]
         [dp (make-vector m (make-vector n (make-hash)))]
         [valid? (lambda (i j) (and (>= i 0) (< i m) (>= j 0) (< j n)))])
    (define (dfs i j balance)
      (cond [(and (= i (sub1 m)) (= j (sub1 n)) (= balance 0)) #t]
            [(not (valid? i j)) #f]
            [else
             (let ([h (hash-ref (vector-ref (vector-ref dp i) j) balance #f)])
               (if h h
                   (let ([res #f]
                         [c (vector-ref (vector-ref grid i) j)])
                     (set! res (or res (and (valid? (add1 i) j) (dfs (add1 i) j (+ balance (if (char=? c #\() 1 -1))) (>= (+ balance (if (char=? c #\() 1 -1)) 0))))
                     (set! res (or res (and (valid? i (add1 j)) (dfs i (add1 j) (+ balance (if (char=? c #\() 1 -1))) (>= (+ balance (if (char=? c #\() 1 -1)) 0)))
                     (hash-set! (vector-ref (vector-ref dp i) j) balance res)
                     res)))]))
    (if (and (> m 0) (> n 0))
        (dfs 0 0 0)
        #f)))