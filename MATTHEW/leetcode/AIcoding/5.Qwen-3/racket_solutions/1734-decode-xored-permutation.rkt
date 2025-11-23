#lang racket

(define (find-absolute-permutation n)
  (define (xor a b) (bitwise-xor a b))
  (define (xor-accumulate lst)
    (if (null? lst)
        0
        (xor (car lst) (xor-accumulate (cdr lst)))))
  (define (find-permutation lst)
    (let ((total (xor-accumulate lst)))
      (let loop ((i 1) (result '()))
        (if (> i n)
            (reverse result)
            (loop (+ i 1) (cons (xor total i) result))))))
  (find-permutation (list 1 2 3 4 5 6 7 8 9 10)))

(define (decode-encrypted-permutation encoded)
  (let ((n (length encoded)))
    (find-absolute-permutation n)))