#lang racket

(define/contract (total-fruit tree)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [count (hash)] [max-count 0])
    (if (= left (length tree))
        max-count
        (let* ([right (car (reverse (hash-keys count)))]
               [current (list-ref tree left)])
          (if (or (hash-has-key? count current) (= (hash-count count) 2))
              (loop (+ left 1) (hash-update count current add1 0) (max max-count (- left right)))
              (loop (+ left 1) (hash-set count current 1) max-count))))) )