(define (findMedianSortedArrays nums1 nums2)
  (define (find-kth k)
    (cond
      [(= (length nums1) 0) (list-ref nums2 (- k 1))]
      [(= (length nums2) 0) (list-ref nums1 (- k 1))]
      [else
       (let* ([half (floor (/ k 2))]
              [i (min (length nums1) (- half 1))]
              [j (min (length nums2) (- half 1))]
              [pivot1 (list-ref nums1 i)]
              [pivot2 (list-ref nums2 j)])
         (cond
           [(< pivot1 pivot2) (find-kth (- k (- i 1)) (drop nums1 (+ i 1)) nums2)]
           [else (find-kth (- k (- j 1)) nums1 (drop nums2 (+ j 1)))]))]))
  (let* ([total (+ (length nums1) (length nums2))]
         [median (if (even? total)
                     (/ (+ (find-kth (/ total 2)) (find-kth (/ total 2 + 1))) 2.0)
                     (find-kth (/ (+ total 1) 2)))])
    median))