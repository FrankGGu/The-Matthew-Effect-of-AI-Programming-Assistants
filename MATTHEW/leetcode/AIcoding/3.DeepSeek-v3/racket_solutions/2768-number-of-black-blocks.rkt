#lang racket

(define (count-black-blocks m n coordinates)
  (define black-hash (make-hash))
  (for ([coord coordinates])
    (hash-set! black-hash coord #t))

  (define count (make-hash))
  (for ([coord coordinates])
    (define x (car coord))
    (define y (cadr coord))
    (for ([i (list 0 1)])
      (for ([j (list 0 1)])
        (when (and (<= 0 (- x i) (- m 2)) (<= 0 (- y j) (- n 2)))
          (define block (list (- x i) (- y j)))
          (hash-update! count block (lambda (v) (+ v 1)) 0)))))

  (define result (make-vector 5 0))
  (hash-for-each count (lambda (k v) (vector-set! result v (+ (vector-ref result v) 1))))

  (define total-blocks (* (- m 1) (- n 1)))
  (vector-set! result 0 (- total-blocks (vector-ref result 1) (vector-ref result 2) (vector-ref result 3) (vector-ref result 4)))

  (vector->list result))