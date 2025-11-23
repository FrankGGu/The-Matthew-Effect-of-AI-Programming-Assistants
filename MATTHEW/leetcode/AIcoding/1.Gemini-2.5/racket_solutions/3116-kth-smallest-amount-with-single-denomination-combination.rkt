#lang racket

(define (count-amounts x denominations)
  (let* ((n (length denominations))
         (total 0))
    ;; Iterate through all non-empty subsets of denominations
    ;; Each 'i' represents a bitmask for the subset
    (for ([i (in-range 1 (expt 2 n))])
      (let* ((current-lcm 1)
             (set-size 0)
             (too-large-lcm? #f)) ; Flag to indicate if lcm has exceeded x

        ;; Calculate LCM for the current subset of denominations
        (for ([j (in-range n)])
          (when (logbit? j i) ; Check if j-th denomination is in the current subset
            (set! set-size (add1 set-size))
            (unless too-large-lcm? ; Only compute lcm if it's not already too large
              (set! current-lcm (lcm current-lcm (list-ref denominations j)))
              ;; If current-lcm exceeds x, then floor(x / current-lcm) will be 0.
              ;; Further LCM computations with this value will also result in a value > x.
              ;; So, we can mark it as "too large" and effectively treat it as infinity.
              (when (> current-lcm x)
                (set! too-large-lcm? #t)))))

        ;; Apply inclusion-exclusion: add or subtract based on subset size
        (unless too-large-lcm? ; Only add/subtract if lcm is not effectively infinity
          (let ((term (floor (/ x current-lcm))))
            (if (odd? set-size)
                (set! total (+ total term))
                (set! total (- total term)))))))
    total))

(define (kth-smallest-amount k denominations)
  (let* ((low 1)
         ;; The maximum possible answer can be estimated.
         ;; If denominations = [1], the k-th amount is k.
         ;; If denominations = [10^5] and k = 10^9, the k-th amount is 10^5 * 10^9 = 10^14.
         ;; So, 10^14 is a safe upper bound for the binary search.
         (high 100000000000000) ; 10^14
         (ans high)) ; Initialize answer with a large value

    ;; Perform binary search on the answer
    (while (<= low high)
      (let* ((mid (floor (/ (+ low high) 2)))
             (count-val (count-amounts mid denominations)))
        (if (>= count-val k)
            ;; If count-val is >= k, mid could be the answer or too large.
            ;; Try to find a smaller answer.
            (begin
              (set! ans mid)
              (set! high (- mid 1)))
            ;; If count-val is < k, mid is too small.
            ;; Look for a larger amount.
            (set! low (+ mid 1)))))
    ans))