(define (min-sum-squared-difference nums1 nums2 k)
  (define (squared-difference lst1 lst2)
    (apply + (map (lambda (x y) (expt (- x y) 2)) lst1 lst2)))

  (define (helper nums1 nums2 k)
    (if (null? nums1)
        0
        (let* ((n (length nums1))
               (min-idx (apply min (map (lambda (i) (if (>= (car (list-ref nums1 i)) k) i #f)) (iota n))))
               (min-val (if min-idx (car (list-ref nums1 min-idx)) 0))
               (new-nums (remove (lambda (x) (= x min-val)) nums2)))
          (+ (expt min-val k) (helper (cdr nums1) new-nums k)))))

  (helper (sort nums1 <) (sort nums2 <) k))

(define (minSumSquareDiff nums1 nums2 k)
  (min-sum-squared-difference nums1 nums2 k))