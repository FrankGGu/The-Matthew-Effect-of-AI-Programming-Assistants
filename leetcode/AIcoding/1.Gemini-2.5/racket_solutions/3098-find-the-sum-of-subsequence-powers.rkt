#lang racket

(define (power base exp)
  (define MOD 1000000007)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (modulo (* b b) MOD) (quotient e 2) (modulo (* res b) MOD)))
      (else (loop (modulo (* b b) MOD) (quotient e 2) res)))))

(define (solve nums k p)
  (define MOD 1000000007)
  (define N (length nums))

  (define sorted-nums (list->vector (sort nums <)))

  ;; dp[i][j][min_idx] = number of subsequences of length j
  ;; ending at sorted-nums[i] (as the maximum element)
  ;; with sorted-nums[min_idx] as the minimum element.
  ;; i: index of the current maximum element in sorted-nums
  ;; j: current length of the subsequence
  ;; min_idx: index of the current minimum element in sorted-nums
  (define dp (make-vector N))
  (for ([i (in-range N)])
    (vector-set! dp i (make-vector (add1 k)))
    (for ([j (in-range (add1 k))])
      (vector-set! (vector-ref dp i) j (make-vector N 0))))

  ;; Base cases: subsequences of length 1
  ;; A subsequence of length 1, [sorted-nums[i]], has sorted-nums[i] as both min and max.
  (for ([i (in-range N)])
    (vector-set! (vector-ref (vector-ref dp i) 1) i 1))

  ;; Fill DP table
  ;; j iterates from 2 to k (subsequence length)
  ;; min_idx iterates from 0 to N-1 (index of the minimum element)
  ;; i iterates from min_idx + 1 to N-1 (index of the maximum element)
  (for ([j (in-range 2 (add1 k))])
    (for ([min_idx (in-range N)])
      (let loop-i ((i (+ min_idx 1)) (current-sum-of-prev-dp-values 0))
        (when (< i N)
          ;; current-sum-of-prev-dp-values accumulates dp[prev_idx][j-1][min_idx]
          ;; for prev_idx from min_idx up to i-1.
          ;; When we are at index i, we add dp[i-1][j-1][min_idx] to the sum
          ;; to get the sum for prev_idx up to i-1.
          (define new-sum
            (modulo (+ current-sum-of-prev-dp-values
                       (vector-ref (vector-ref (vector-ref dp (- i 1)) (- j 1)) min_idx))
                    MOD))
          (vector-set! (vector-ref (vector-ref dp i) j) min_idx new-sum)
          (loop-i (+ i 1) new-sum)))))

  ;; Calculate total sum of powers
  (define total-sum 0)
  (for ([i (in-range N)])
    (for ([min_idx (in-range (add1 i))]) ; min_idx must be less than or equal to i
      (define count (vector-ref (vector-ref (vector-ref dp i) k) min_idx))
      (when (> count 0)
        (define diff (- (vector-ref sorted-nums i) (vector-ref sorted-nums min_idx)))
        (define term (modulo (* (power diff p) count) MOD))
        (set! total-sum (modulo (+ total-sum term) MOD)))))

  total-sum)