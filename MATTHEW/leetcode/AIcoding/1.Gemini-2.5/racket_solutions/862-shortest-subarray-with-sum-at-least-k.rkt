#lang racket

(require racket/collection)

(define (shortest-subarray-sum-at-least-k A K)
  (define N (vector-length A))
  (define P (make-vector (+ N 1) 0)) ; Prefix sums: P[i] = sum(A[0]...A[i-1])

  ;; Calculate prefix sums
  (for ([i (in-range N)])
    (vector-set! P (+ i 1) (+ (vector-ref P i) (vector-ref A i))))

  (define min-len (+ N 1)) ; Initialize with a value larger than any possible length
  (define dq (make-deque)) ; Stores indices j such that P[j] is increasing

  ;; Iterate through P indices (0 to N)
  (for ([i (in-range (+ N 1))])
    (let ([current-P-i (vector-ref P i)])
      ;; While the deque is not empty and a valid subarray sum is found
      ;; from the front of the deque, update min-len and remove the front.
      (while (and (not (deque-empty? dq))
                  (>= (- current-P-i (vector-ref P (deque-front dq))) K))
        (set! min-len (min min-len (- i (deque-front dq))))
        (deque-remove-front! dq))

      ;; While the deque is not empty and the current prefix sum is less than
      ;; or equal to the prefix sum at the back of the deque, remove from back.
      ;; This maintains the invariant that P[j] values for indices j in deque are increasing.
      (while (and (not (deque-empty? dq))
                  (<= current-P-i (vector-ref P (deque-back dq))))
        (deque-remove-back! dq))

      ;; Add the current index to the back of the deque.
      (deque-add-back! dq i)))

  (if (= min-len (+ N 1))
      -1
      min-len))