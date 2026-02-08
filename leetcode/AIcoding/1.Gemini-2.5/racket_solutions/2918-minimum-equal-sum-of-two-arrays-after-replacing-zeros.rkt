(define (get-sum-and-zeros nums)
  (let loop ((lst nums) (current-sum 0) (zero-count 0))
    (cond
      ((null? lst) (list current-sum zero-count))
      ((zero? (car lst)) (loop (cdr lst) current-sum (+ zero-count 1)))
      (else (loop (cdr lst) (+ current-sum (car lst)) zero-count)))))

(define (minimum-equal-sum-of-two-arrays-after-replacing-zeros nums1 nums2)
  (let* ((stats1 (get-sum-and-zeros nums1))
         (sum1 (car stats1))
         (zeros1 (cadr stats1))
         (stats2 (get-sum-and-zeros nums2))
         (sum2 (car stats2))
         (zeros2 (cadr stats2)))

    (define min-s1 (+ sum1 zeros1))
    (define min-s2 (+ sum2 zeros2))

    (cond
      ((and (= zeros1 0) (= zeros2 0))
       (if (= sum1 sum2) sum1 -1))

      ((and (> zeros1 0) (= zeros2 0))
       (if (<= min-s1 sum2) sum2 -1))

      ((and (= zeros1 0) (> zeros2 0))
       (if (<= min-s2 sum1) sum1 -1))

      ((and (> zeros1 0) (> zeros2 0))
       (max min-s1 min-s2))
      )))