#lang racket

(define (xor-queries-of-a-subarray nums queries)
  (define n (length nums))
  (define prefix (make-vector (+ n 1) 0))
  (for ([i (in-range n)])
    (vector-set! prefix (+ i 1) (bitwise-xor (vector-ref prefix i) (vector-ref nums i))))
  (for/list ([q (in-range (length queries))])
    (let* ([l (car (list-ref queries q))]
           [r (cadr (list-ref queries q))]
           [res (bitwise-xor (vector-ref prefix (+ r 1)) (vector-ref prefix l))])
      res)))