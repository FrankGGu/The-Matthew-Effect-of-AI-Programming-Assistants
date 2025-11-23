#lang racket

(define (max-value-of-k-coins-from-piles piles k)
  (define (dfs idx k remaining)
    (cond [(= idx (length piles)) 0]
          [(= k 0) 0]
          [else
           (let ([max-val 0])
             (for ([i (in-range (min (add1 (vector-length (vector-ref piles idx))) k))])
               (when (<= i (vector-length (vector-ref piles idx)))
                 (set! max-val (max max-val (apply + (take (vector-ref piles idx) i)) (dfs (add1 idx) (- k i) (sub1 remaining)))))
               )
             max-val
             )]))
  (dfs 0 k 0))