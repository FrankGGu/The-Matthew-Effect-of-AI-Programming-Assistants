#lang racket

(define MOD 1000000007)

(define (pow base exp)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (modulo (* b b) MOD) (quotient e 2) (modulo (* res b) MOD)))
      (else (loop (modulo (* b b) MOD) (quotient e 2) res)))))

(define (inv n)
  (pow n (- MOD 2)))

(define MAX_N_PLUS_K 1999) 
(define factorials (make-vector (+ MAX_N_PLUS_K 1)))

(vector-set! factorials 0 1)
(for ((i (in-range 1 (+ MAX_N_PLUS_K 1))))
  (vector-set! factorials i (modulo (* (vector-ref factorials (- i 1)) i) MOD)))

(define (nCk n k)
  ;; Assumes n >= k and k >= 0 based on problem context.
  ;; Also assumes n is within MAX_N_PLUS_K bounds.
  (if (or (= k 0) (= k n))
      1
      (let* ((num (vector-ref factorials n))
             (den1 (vector-ref factorials k))
             (den2 (vector-ref factorials (- n k)))
             (inv-den1 (inv den1))
             (inv-den2 (inv den2)))
        (modulo (* num inv-den1 inv-den2) MOD))))

(define (find-nth-value n k)
  ;; The problem asks for the value at index n-1 after k seconds.
  ;; This is equivalent to calculating the binomial coefficient (n-1+k) choose k.
  ;; Or equivalently, (n-1+k) choose (n-1).
  (let* ((N_comb (+ (- n 1) k))
         (K_comb k))
    (nCk N_comb K_comb)))