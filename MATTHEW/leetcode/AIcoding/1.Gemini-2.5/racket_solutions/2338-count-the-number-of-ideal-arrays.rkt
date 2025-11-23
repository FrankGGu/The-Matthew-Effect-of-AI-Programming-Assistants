#lang racket

(define MOD 1000000007)

(define (countIdealArrays n maxValue)

  (define (power base exp)
    (let loop ((b base) (e exp) (res 1))
      (cond
        ((zero? e) res)
        ((odd? e) (loop (modulo (* b b) MOD) (quotient e 2) (modulo (* res b) MOD)))
        (else (loop (modulo (* b b) MOD) (quotient e 2) res)))))

  (define (mod-inverse n)
    (power n (- MOD 2)))

  ;; Max exponent for any prime p such that p^e <= maxValue (10^4)
  ;; For p=2, 2^13 = 8192, 2^14 = 16384. So max exponent is 13.
  ;; The maximum value for N in nCk(N, K) is (max_exponent + n - 1).
  ;; So max_comb_n = 13 + n - 1.
  (define max-comb-n (+ n 13)) 

  (define fact (make-vector (+ max-comb-n 1)))
  (define invfact (make-vector (+ max-comb-n 1)))

  (vector-set! fact 0 1)
  (vector-set! invfact 0 1)
  (for ((i (in-range 1 (+ max-comb-n 1))))
    (vector-set! fact i (modulo (* (vector-ref fact (- i 1)) i) MOD))
    (vector-set! invfact i (mod-inverse (vector-ref fact i))))

  (define (nCk n k)
    (cond
      ((or (< k 0) (> k n)) 0)
      (else
       (modulo (* (vector-ref fact n)
                  (vector-ref invfact k)
                  (vector-ref invfact (- n k)))
               MOD))))

  (define spf (make-vector (+ maxValue 1) 0)) ; Smallest Prime Factor

  ;; Sieve to precompute SPF for numbers up to maxValue
  (for ((i (in-range 2 (+ maxValue 1))))
    (when (zero? (vector-ref spf i))
      (vector-set! spf i i)
      (for ((j (in-range (* i i) (+ maxValue 1) i)))
        (when (zero? (vector-ref spf j))
          (vector-set! spf j i)))))

  (let ((total-ans 0))
    (for ((val (in-range 1 (+ maxValue 1))))
      (let ((ways-for-val 1)
            (temp-val val))

        (let loop ((current-val temp-val))
          (unless (= current-val 1)
            (let* ((p (vector-ref spf current-val))
                   (e 0)
                   (divisor-power 1))
              (let inner-loop ((cv current-val))
                (when (zero? (modulo cv p))
                  (set! e (+ e 1))
                  (set! divisor-power (* divisor-power p))
                  (inner-loop (quotient cv p))))
              (set! ways-for-val (modulo (* ways-for-val (nCk (+ e n - 1) (- n 1))) MOD))
              (loop (quotient current-val divisor-power))))))

        (set! total-ans (modulo (+ total-ans ways-for-val) MOD))))
    total-ans))