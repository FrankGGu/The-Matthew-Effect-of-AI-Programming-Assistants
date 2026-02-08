#lang racket

(define MOD 1000000007)

(define (power base exp)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((even? e) (loop (modulo (* b b) MOD) (/ e 2) res))
      (else (loop (modulo (* b b) MOD) (/ (- e 1) 2) (modulo (* res b) MOD))))))

(define (min-non-zero-product p)
  (if (= p 1)
      1
      (let* ((val (- (expt 2 p) 2))
             (count (- (expt 2 (- p 1)) 1))
             (last-val (- (expt 2 p) 1)))
        (modulo (* (power val count) last-val) MOD))))

(provide (all-defined-out))