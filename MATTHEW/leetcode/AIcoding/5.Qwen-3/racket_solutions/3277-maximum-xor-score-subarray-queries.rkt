#lang racket

(define (max-xor-score-subarray-queries nums queries)
  (define n (length nums))
  (define prefix (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix (+ i 1) (bitwise-xor (vector-ref prefix i) (vector-ref nums i))))

  (define (query l r)
    (bitwise-xor (vector-ref prefix (+ r 1)) (vector-ref prefix l)))

  (map (lambda (q) (query (car q) (cadr q))) queries))