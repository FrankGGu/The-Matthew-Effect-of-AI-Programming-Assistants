#lang racket/base

(define MAX_VAL 100000)

(define parent (make-vector (+ MAX_VAL 1)))
(define spf (make-vector (+ MAX_VAL 1)))

(define (dsu-init)
  (for ([i (in-range (+ MAX_VAL 1))])
    (vector-set! parent i i)))

(define (find i)
  (if (= (vector-ref parent i) i)
      i
      (let ([root (find (vector-ref parent i))])
        (vector-set! parent i root)
        root)))

(define (union i j)
  (let ([root-i (find i)]
        [root-j (find j)])
    (unless (= root-i root-j)
      (vector-set! parent root-i root-j))))

(define (sieve)
  ;; Initialize spf[i] = i
  (for ([i (in-range (+ MAX_VAL 1))])
    (vector-set! spf i i))

  ;; Iterate from 2 up to MAX_VAL
  (for ([i (in-range 2 (+ MAX_VAL 1))])
    (when (= (vector-ref spf i) i) ; If i is prime (its SPF is itself)
      ;; Mark multiples of i. Start from i*i because smaller multiples
      ;; would have already been marked by smaller prime factors.
      (for ([j (in-range (* i i) (+ MAX_VAL 1) i)])
        (when (= (vector-ref spf j) j) ; Only update if not already marked by a smaller prime
          (vector-set! spf j i))))))

(define (get-prime-factors n)
  (let loop ([num n] [factors '()])
    (if (<= num 1) ; Base case: 0 or 1 has no prime factors relevant for GCD > 1
        factors
        (let ([p (vector-ref spf num)])
          (loop (/ num p) (cons p factors))))))

(define (gcd-sort nums)
  ;; Initialize SPF and DSU structures once per call.
  (sieve)
  (dsu-init)

  ;; For each number in the input array, connect it to all its prime factors
  ;; in the DSU. This effectively groups numbers that share common prime factors.
  (for ([num (in-list nums)])
    (when (> num 1) ; Numbers <= 1 do not have prime factors > 1
      (let ([factors (get-prime-factors num)])
        (for ([p (in-list factors)])
          (union num p)))))

  ;; Create a sorted version of the input array.
  (define sorted-nums (sort nums <))

  ;; Check if each number in the original array belongs to the same DSU component
  ;; as the number that should be in its position in the sorted array.
  ;; If all corresponding elements are in the same component, it's possible to sort.
  (for/and ([original-num (in-list nums)]
            [sorted-num (in-list sorted-nums)])
    (= (find original-num) (find sorted-num))))