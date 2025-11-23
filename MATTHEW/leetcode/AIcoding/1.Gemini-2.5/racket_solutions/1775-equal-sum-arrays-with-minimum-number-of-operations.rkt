#lang racket

(define (min-operations nums1 nums2)
  (let* ([len1 (length nums1)]
         [len2 (length nums2)])
    ;; Initial check for impossibility:
    ;; If the maximum possible sum of one array is less than the minimum possible sum of the other,
    ;; then it's impossible to make their sums equal.
    (if (or (< (* len1 6) (* len2 1))
            (< (* len2 6) (* len1 1)))
        -1
        ;; If it's potentially possible, proceed with the greedy strategy
        (let* ([s1 (foldl + 0 nums1)]
               [s2 (foldl + 0 nums2)])

          ;; If sums are already equal, 0 operations needed
          (if (= s1 s2)
              0
              ;; Otherwise, perform operations greedily
              (let* ([smaller-sum (min s1 s2)]
                     [larger-sum (max s1 s2)]
                     [diff (- larger-sum smaller-sum)]
                     ;; Determine which array needs to increase its sum
                     ;; and which needs to decrease its sum to bridge the difference
                     [arr-to-increase (if (< s1 s2) nums1 nums2)]
                     [arr-to-decrease (if (< s1 s2) nums2 nums1)]

                     ;; Calculate all possible "gains" (reduction in difference)
                     ;; For elements in arr-to-increase: changing x to 6 gives a gain of (6 - x)
                     [gains-from-increase (map (lambda (x) (- 6 x)) arr-to-increase)]
                     ;; For elements in arr-to-decrease: changing x to 1 gives a gain of (x - 1)
                     [gains-from-decrease (map (lambda (x) (- x 1)) arr-to-decrease)]

                     ;; Combine all gains and sort them in descending order
                     [all-gains (append gains-from-increase gains-from-decrease)]
                     [sorted-gains (sort all-gains >)])

                ;; Iterate through the sorted gains, applying the largest gains first
                (let loop ([current-diff diff]
                           [gains-list sorted-gains]
                           [operations 0])
                  (cond
                    [(<= current-diff 0) operations] ; Difference has been covered
                    [(empty? gains-list) -1] ; Should ideally not be reached if initial check is correct and diff > 0
                                             ; but serves as a safeguard.
                    [else
                     (loop (- current-diff (car gains-list))
                           (cdr gains-list)
                           (+ operations 1))]))))))))