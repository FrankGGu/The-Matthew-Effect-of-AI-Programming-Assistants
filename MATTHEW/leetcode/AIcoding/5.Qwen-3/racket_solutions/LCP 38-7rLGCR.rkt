#lang racket

(define (guard-castle n m)
  (define grid (make-vector n #f))
  (define (dfs row cols diag1 diag2)
    (cond [(= row n) 1]
          [else
           (for/fold ([count 0]) ([col (in-range n)])
             (if (and (not (vector-ref grid col))
                      (not (set-member? cols col))
                      (not (set-member? diag1 (- row col)))
                      (not (set-member? diag2 (+ row col))))
                 (+ count (dfs (+ row 1)
                                (set-add cols col)
                                (set-add diag1 (- row col))
                                (set-add diag2 (+ row col))))
                 count))]))
  (dfs 0 (set) (set) (set)))