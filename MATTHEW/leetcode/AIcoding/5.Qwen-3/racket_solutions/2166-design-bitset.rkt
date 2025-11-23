#lang racket

(define (make-bitset)
  (let ((bits '()))
    (lambda (op . args)
      (cond
        [(equal? op 'fix) (set! bits args)]
        [(equal? op 'set) (set! bits (map (lambda (x) (if (= x 1) 1 0)) args))]
        [(equal? op 'flip) (set! bits (map (lambda (x) (- 1 x)) bits))]
        [(equal? op 'get) (list-ref bits (car args))]
        [(equal? op 'to-string) (apply string (map (lambda (x) (if (= x 1) #\1 #\0)) bits))]
        [(equal? op 'count) (length (filter (lambda (x) (= x 1)) bits))]))))

(define (solution)
  (let ((bitset (make-bitset)))
    (bitset 'fix 1 0 0 1 0 1 0 1)
    (bitset 'set 1 1 0 0 1 1 0 0)
    (bitset 'flip)
    (bitset 'get 3)
    (bitset 'to-string)
    (bitset 'count)))