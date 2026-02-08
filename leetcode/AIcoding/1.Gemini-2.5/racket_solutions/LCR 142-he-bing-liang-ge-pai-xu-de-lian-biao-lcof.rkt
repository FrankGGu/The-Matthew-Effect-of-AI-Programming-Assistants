(define (min-total-cost nums1 nums2 k)
  ;; Sort nums1 in non-decreasing order
  (define sorted-nums1 (sort nums1 <))
  ;; Sort nums2 in non-decreasing order
  (define sorted-nums2 (sort nums2 <))

  ;; Calculate the total cost by pairing the i-th smallest from nums1
  ;; with the (k-1-i)-th smallest from nums2.
  (for/sum ([i (in-range k)])
    (* (list-ref sorted-nums1 i)
       (list-ref sorted-nums2 (- k 1 i)))))