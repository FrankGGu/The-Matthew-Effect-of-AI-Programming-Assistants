#lang racket

(define primes '(2 3 5 7 11 13 17 19 23 29))

(define (get-mask x)
  (let loop ([x x] [mask 0] [ps primes])
    (cond
      [(null? ps) mask]
      [(zero? (modulo x (car ps)))
       (if (zero? (modulo (quotient x (car ps)) (car ps)))
           -1
           (loop (quotient x (car ps)) (bitwise-ior mask (arithmetic-shift 1 (length (cdr ps)))) (cdr ps))]
      [else (loop x mask (cdr ps))])))

(define (square-free-subsets nums)
  (define masks (filter (lambda (x) (not (= x -1))) (map get-mask nums)))
  (define mod 1000000007)
  (define dp (make-hash))
  (hash-set! dp 0 1)
  (for ([mask masks])
    (define new-dp (hash-copy dp))
    (hash-for-each
     dp
     (lambda (k v)
       (when (zero? (bitwise-and k mask))
         (hash-update! new-dp (bitwise-ior k mask) (lambda (old) (modulo (+ old v) mod)) (lambda () 0))))
    (set! dp new-dp))
  (modulo (- (apply + (hash-values dp)) 1) mod))