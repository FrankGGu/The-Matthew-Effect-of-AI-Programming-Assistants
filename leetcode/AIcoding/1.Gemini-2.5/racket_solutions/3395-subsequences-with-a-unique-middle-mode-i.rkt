#lang racket

(define MOD 1000000007)

(define (power base exp)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (modulo (* b b) MOD) (quotient e 2) (modulo (* res b) MOD)))
      (else (loop (modulo (* b b) MOD) (quotient e 2) res)))))

(define (mod-inverse n)
  (power n (sub1 MOD)))

(define (precompute-factorials n-max)
  (let* ((fact (make-vector (add1 n-max)))
         (inv-fact (make-vector (add1 n-max))))
    (vector-set! fact 0 1)
    (vector-set! inv-fact 0 1)
    (for ((i (in-range 1 (add1 n-max))))
      (vector-set! fact i (modulo (* (vector-ref fact (sub1 i)) i) MOD)))
    (vector-set! inv-fact n-max (mod-inverse (vector-ref fact n-max)))
    (for ((i (in-range (sub1 n-max) 0 -1)))
      (vector-set! inv-fact i (modulo (* (vector-ref inv-fact (add1 i)) (add1 i)) MOD)))
    (list fact inv-fact)))

(define (make-binom fact inv-fact)
  (lambda (n k)
    (cond
      ((< k 0) 0)
      ((> k n) 0)
      (else
       (modulo
        (* (vector-ref fact n)
           (vector-ref inv-fact k)
           (vector-ref inv-fact (- n k)))
        MOD)))))

(define (subsequences-with-unique-middle-mode-i nums)
  (define N (vector-length nums))

  (define-values (fact inv-fact) (apply values (precompute-factorials N)))
  (define binom (make-binom fact inv-fact))

  (define total-ans 0)

  (for ((i (in-range N)))
    (define target-val (vector-ref nums i))

    (define left-target-count 0)
    (for ((p (in-range i)))
      (when (= (vector-ref nums p) target-val)
        (set! left-target-count (add1 left-target-count))))

    (define right-target-count 0)
    (for ((p (in-range (add1 i) N)))
      (when (= (vector-ref nums p) target-val)
        (set! right-target-count (add1 right-target-count))))

    (for ((k (in-range (add1 (min left-target-count right-target-count)))))
      (define ways-left (binom left-target-count k))
      (define ways-right (binom right-target-count k))
      (set! total-ans (modulo (+ total-ans (modulo (* ways-left ways-right) MOD)) MOD)))
    )
  total-ans)