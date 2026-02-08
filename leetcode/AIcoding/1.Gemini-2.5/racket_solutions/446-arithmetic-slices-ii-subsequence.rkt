#lang racket

(define (number-of-arithmetic-slices-ii-subsequence nums)
  (define N (length nums))

  (if (< N 3)
      0
      (begin
        (define nums-vec (list->vector nums))
        (define dp (make-vector N (lambda () (make-hash)))) ; vector of mutable hash tables
        (define total-count 0)

        (for ([i (in-range N)])
          (for ([j (in-range i)])
            (define diff (- (vector-ref nums-vec i) (vector-ref nums-vec j)))

            (define count-j-diff (hash-ref (vector-ref dp j) diff 0))
            (define count-i-diff (hash-ref (vector-ref dp i) diff 0))

            ;; Add to total-count: any arithmetic subsequence of length >= 2
            ;; ending at j with 'diff' can be extended by nums[i] to form
            ;; an arithmetic subsequence of length >= 3.
            (set! total-count (+ total-count count-j-diff))

            ;; Update dp[i][diff]:
            ;; This represents the total count of arithmetic subsequences of length >= 2
            ;; ending at i with common difference 'diff'.
            ;; It includes:
            ;; 1. Existing ones ending at i with 'diff' (count-i-diff).
            ;; 2. New ones formed by extending subsequences ending at j with 'diff' (count-j-diff).
            ;; 3. The new length-2 subsequence (nums[j], nums[i]) (+1).
            (hash-set! (vector-ref dp i) diff (+ count-i-diff count-j-diff 1))
            ))
        total-count)))