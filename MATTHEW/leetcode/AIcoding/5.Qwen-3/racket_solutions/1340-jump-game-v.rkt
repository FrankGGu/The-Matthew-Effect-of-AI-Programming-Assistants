#lang racket

(define (jump-game-v arr)
  (define n (length arr))
  (define dp (make-vector n -1))
  (define (dfs i)
    (if (>= i n) 0
        (if (not (= (vector-ref dp i) -1))
            (vector-ref dp i)
            (let ((res 1))
              (when (> i 0) (when (< (list-ref arr (- i 1)) (list-ref arr i)) (set! res (+ res (dfs (- i 1))))))
              (when (< i (- n 1)) (when (< (list-ref arr (+ i 1)) (list-ref arr i)) (set! res (+ res (dfs (+ i 1))))))
              (vector-set! dp i res)
              res))))
  (for/sum ((i (in-range n))) (dfs i)))