#lang racket
(require data/heap)

(define (minimum-difference nums)
  (define N (/ (vector-length nums) 3))
  (define 3N (vector-length nums))

  ;; left-min-sums[i]: min sum of N elements from nums[0...i]
  ;; We use a max-heap of size N to keep track of the N smallest elements.
  (define left-min-sums (make-vector (* 2 N) #f)) ; #f indicates not yet computed
  (define pq-for-left (heap >)) ; Max-heap (uses > for comparison)
  (define current-sum-left 0)

  (for ([i (in-range (* 2 N))]) ; Iterate from 0 to 2N-1
    (define val (vector-ref nums i))
    (set! pq-for-left (heap-add pq-for-left val))
    (set! current-sum-left (+ current-sum-left val))

    (when (> (heap-size pq-for-left) N)
      (define largest-in-heap-val (heap-min pq-for-left)) ; This is the largest element in the max-heap
      (set! pq-for-left (heap-remove-min pq-for-left))
      (set! current-sum-left (- current-sum-left largest-in-heap-val)))

    (when (= (heap-size pq-for-left) N)
      (vector-set! left-min-sums i current-sum-left)))

  ;; right-max-sums[i]: max sum of N elements from nums[i...3N-1]
  ;; We use a min-heap of size N to keep track of the N largest elements.
  (define right-max-sums (make-vector 3N #f)) ; #f indicates not yet computed
  (define pq-for-right (heap <)) ; Min-heap (uses < for comparison)
  (define current-sum-right 0)

  (for ([i (in-range (- 3N 1) (- N 1) -1)]) ; Iterate from 3N-1 down to N
    (define val (vector-ref nums i))
    (set! pq-for-right (heap-add pq-for-right val))
    (set! current-sum-right (+ current-sum-right val))

    (when (> (heap-size pq-for-right) N)
      (define smallest-in-heap-val (heap-min pq-for-right)) ; This is the smallest element in the min-heap
      (set! pq-for-right (heap-remove-min pq-for-right))
      (set! current-sum-right (- current-sum-right smallest-in-heap-val)))

    (when (= (heap-size pq-for-right) N)
      (vector-set! right-max-sums i current-sum-right)))

  ;; Calculate minimum difference
  (define min-diff (expt 10 15)) ; A sufficiently large integer for initial minimum difference

  ;; The split point k is such that sum1 is from nums[0...k] and sum2 is from nums[k+1...3N-1]
  ;; k ranges from N-1 to 2N-1
  (for ([k (in-range (- N 1) (* 2 N))])
    (define left-sum (vector-ref left-min-sums k))
    (define right-sum (vector-ref right-max-sums (+ k 1)))
    (when (and (not (eq? left-sum #f)) (not (eq? right-sum #f))) ; Check if values are computed
      (set! min-diff (min min-diff (- left-sum right-sum)))))

  min-diff)