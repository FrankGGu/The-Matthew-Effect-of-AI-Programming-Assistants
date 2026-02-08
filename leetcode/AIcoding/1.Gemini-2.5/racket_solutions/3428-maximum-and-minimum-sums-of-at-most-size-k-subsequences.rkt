#lang racket

(define MOD (+ (expt 10 9) 7))

(define (mod-expt base exp modulus)
  (let loop ((b base) (e exp) (res 1))
    (cond ((zero? e) res)
          ((odd? e) (loop (modulo (* b b) modulus) (quotient e 2) (modulo (* res b) modulus)))
          (else (loop (modulo (* b b) modulus) (quotient e 2) res)))))

(define (mod-inv n modulus)
  (mod-expt n (- modulus 2) modulus))

(define (solve nums k)
  (define n (length nums))
  ;; Sort the numbers to easily identify min/max in subsequences
  (define sorted-nums (sort nums <))

  ;; Precompute factorials and inverse factorials modulo MOD
  ;; These are needed for combinations C(n, r)
  (define max-n-for-combinations n) ; Max 'n' value needed for C(n,r)
  (define facts (make-vector (+ max-n-for-combinations 1)))
  (define inv-facts (make-vector (+ max-n-for-combinations 1)))

  (vector-set! facts 0 1)
  (vector-set! inv-facts 0 1)
  (for ((i (range 1 (+ max-n-for-combinations 1))))
    (vector-set! facts i (modulo (* (vector-ref facts (- i 1)) i) MOD))
    (vector-set! inv-facts i (mod-inv (vector-ref facts i) MOD)))

  ;; C(n, r) function: calculates "n choose r" modulo MOD
  (define (combinations n r)
    (cond
      ((< r 0) 0) ; Cannot choose negative number of items
      ((> r n) 0) ; Cannot choose more items than available
      (else
       (modulo
        (* (vector-ref facts n)
           (vector-ref inv-facts r)
           (vector-ref inv-facts (- n r)))
        MOD))))

  ;; f(n, m) function: calculates sum_{r=0}^{m} C(n, r) modulo MOD
  (define (sum-combinations n m)
    (cond
      ((< m 0) 0) ; Sum up to negative index is 0
      ((>= m n) (mod-expt 2 n MOD)) ; Sum C(n,r) for r=0..n is 2^n
      (else
       ;; Otherwise, sum C(n,r) from r=0 to m
       (let loop ((r 0) (current-sum 0))
         (if (> r m)
             current-sum
             (loop (+ r 1) (modulo (+ current-sum (combinations n r)) MOD)))))))

  ;; Main loop to calculate the total sum
  (let ((total-sum 0))
    (for ((i (range n)))
      (define num-i (list-ref sorted-nums i))

      ;; X_i: Count of subsequences where sorted-nums[i] is the maximum element.
      ;; These subsequences must include sorted-nums[i] and all other elements
      ;; must be chosen from sorted-nums[0...i-1].
      ;; Let 'p' be the number of elements chosen from sorted-nums[0...i-1].
      ;; The total length is 1 (for sorted-nums[i]) + p.
      ;; This length must be at most k, so 1 + p <= k => p <= k-1.
      ;; Also, p cannot exceed 'i' (the number of available elements).
      ;; So, p ranges from 0 to min(i, k-1).
      (define X_i (sum-combinations i (min i (- k 1))))

      ;; Y_i: Count of subsequences where sorted-nums[i] is the minimum element.
      ;; These subsequences must include sorted-nums[i] and all other elements
      ;; must be chosen from sorted-nums[i+1...n-1].
      ;; Let 'p' be the number of elements chosen from sorted-nums[i+1...n-1].
      ;; The total length is 1 (for sorted-nums[i]) + p.
      ;; This length must be at most k, so 1 + p <= k => p <= k-1.
      ;; Also, p cannot exceed 'n-1-i' (the number of available elements).
      ;; So, p ranges from 0 to min(n-1-i, k-1).
      (define Y_i (sum-combinations (- n 1 i) (min (- n 1 i) (- k 1))))

      ;; Add contribution of sorted-nums[i] to the total sum
      ;; sorted-nums[i] is added as max X_i times and as min Y_i times.
      (set! total-sum (modulo (+ total-sum
                                 (modulo (* num-i X_i) MOD)
                                 (modulo (* num-i Y_i) MOD))
                               MOD)))
    total-sum))