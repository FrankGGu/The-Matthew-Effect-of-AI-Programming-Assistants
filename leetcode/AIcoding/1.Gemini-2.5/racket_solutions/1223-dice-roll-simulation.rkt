#lang racket

(define (dice-roll-simulation n rollMax)
  (define MOD 1000000007)
  (define NUM_FACES 6)

  ;; dp[i][j] = number of distinct sequences of length i ending with face j
  (define dp (make-vector (add1 n) #f)) ; Initialize with placeholders
  (for ([k (in-range (add1 n))])
    (vector-set! dp k (make-vector NUM_FACES 0)))

  ;; S[i] = total number of distinct sequences of length i
  (define S (make-vector (add1 n) 0))

  ;; Base case: S[0] = 1 (empty sequence)
  (vector-set! S 0 1)

  (for ([i (in-range 1 (add1 n))])
    (for ([j (in-range NUM_FACES)])
      (define current-dp-ij 0)
      (for ([x (in-range 1 (add1 (vector-ref rollMax j)))])
        (when (>= (- i x) 0)
          (define term (vector-ref S (- i x)))
          (when (> (- i x) 0)
            ;; Subtract sequences of length (i-x) that end with j.
            ;; This ensures that the (i-x)-th roll is NOT j,
            ;; so we are appending exactly x 'j's.
            (set! term (modulo (- term (vector-ref (vector-ref dp (- i x)) j)) MOD)))
          (set! current-dp-ij (modulo (+ current-dp-ij term) MOD))))
      (vector-set! (vector-ref dp i) j current-dp-ij))

    (define current-S-i 0)
    (for ([k (in-range NUM_FACES)])
      (set! current-S-i (modulo (+ current-S-i (vector-ref (vector-ref dp i) k)) MOD)))
    (vector-set! S i current-S-i))

  (vector-ref S n))