#lang racket

(define (count-incremovable-subarrays nums)
  (define n (length nums))

  (when (= n 0)
    (error "Input list cannot be empty"))

  ;; prefix-strictly-increasing[k] is true if nums[0...k-1] is strictly increasing.
  ;; Size n+1, for k from 0 to n.
  (define prefix-strictly-increasing (make-vector (+ n 1) #t))
  (vector-set! prefix-strictly-increasing 0 #t) ; Empty prefix is strictly increasing
  (for ([k (in-range 1 (+ n 1))])
    (vector-set! prefix-strictly-increasing k
                 (and (vector-ref prefix-strictly-increasing (- k 1))
                      (if (= k 1)
                          #t ; Single element prefix nums[0...0] is strictly increasing
                          (< (list-ref nums (- k 2)) (list-ref nums (- k 1)))))))

  ;; suffix-strictly-increasing[k] is true if nums[k...n-1] is strictly increasing.
  ;; Size n+1, for k from 0 to n.
  (define suffix-strictly-increasing (make-vector (+ n 1) #t))
  (vector-set! suffix-strictly-increasing n #t) ; Empty suffix is strictly increasing
  (for ([k (in-range (- n 1) -1 -1)])
    (vector-set! suffix-strictly-increasing k
                 (and (vector-ref suffix-strictly-increasing (+ k 1))
                      (if (= k (- n 1))
                          #t ; Single element suffix nums[n-1...n-1] is strictly increasing
                          (< (list-ref nums k) (list-ref nums (+ k 1)))))))

  (define total-count 0)
  ;; j-ptr represents the starting index of the right part (suffix) nums[j-ptr...n-1].
  ;; It also corresponds to (end_of_removed_subarray + 1).
  (define j-ptr 0)

  ;; Iterate 'i' from 0 to n.
  ;; 'i' represents the length of the left part nums[0...i-1], and also the start index of the removed subarray.
  (for ([i (in-range (+ n 1))])
    ;; If the prefix nums[0...i-1] is not strictly increasing,
    ;; then any removed subarray starting at 'i' or later cannot result in a valid left part.
    ;; So, we can break early.
    (when (not (vector-ref prefix-strictly-increasing i))
      (break))

    ;; Determine the value of the last element of the left part.
    ;; Use 0 as a sentinel for -infinity because nums[x] >= 1.
    (define left-val (if (> i 0) (list-ref nums (- i 1)) 0))

    ;; The removed subarray is nums[i ... j-ptr-1].
    ;; For it to be a non-empty subarray, we must have i <= j-ptr-1, which means i+1 <= j-ptr.
    ;; We ensure j-ptr is at least i+1.
    (set! j-ptr (max j-ptr (+ i 1)))

    ;; Advance j-ptr to find the smallest valid starting index for the suffix.
    ;; A suffix starting at j-ptr is valid if:
    ;; 1. nums[j-ptr...n-1] is strictly increasing.
    ;; 2. If both left and right parts are non-empty, nums[i-1] < nums[j-ptr].
    (while (<= j-ptr n)
      (when (not (vector-ref suffix-strictly-increasing j-ptr))
        (set! j-ptr (+ j-ptr 1))
        (continue))
      (when (and (< j-ptr n) (>= left-val (list-ref nums j-ptr)))
        (set! j-ptr (+ j-ptr 1))
        (continue))
      (break)) ; Found the smallest valid j-ptr

    ;; After the loop, j-ptr is the smallest index such that nums[j-ptr...n-1]
    ;; forms a valid suffix with nums[0...i-1].
    ;; All indices from j-ptr to n (inclusive) will also form valid suffixes because
    ;; removing more elements (i.e., increasing j-ptr) only makes the suffix shorter (or empty),
    ;; which maintains strict increasing property and the comparison with left-val (if left-val exists).
    ;; The number of valid suffixes (and thus incremovable subarrays for current 'i') is (n - j-ptr + 1).
    ;; We use (max 0 ...) to handle cases where no valid j-ptr is found (j-ptr > n).
    (set! total-count (+ total-count (max 0 (- n j-ptr -1)))))

  total-count)