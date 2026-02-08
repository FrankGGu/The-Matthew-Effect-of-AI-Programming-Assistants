(define (count-triplets arr1 arr2)
  (let ([product-counts (make-hash)]
        [n2 (length arr2)]
        [total-count 0])

    ;; Step 1: Populate product-counts for arr2[j] * arr2[k] with j < k
    (for ([j (in-range n2)])
      (for ([k (in-range (+ j 1) n2)])
        (let ([prod (* (list-ref arr2 j) (list-ref arr2 k))])
          (hash-set! product-counts prod (+ (hash-ref product-counts prod 0) 1)))))

    ;; Step 2: Iterate through arr1 and check against product-counts
    (for ([x (in-list arr1)])
      (let ([target (* x x)])
        (when (hash-has-key? product-counts target)
          (set! total-count (+ total-count (hash-ref product-counts target))))))

    total-count))

(define (num-of-ways-where-square-is-equal-to-product-of-two-numbers nums1 nums2)
  (+ (count-triplets nums1 nums2)
     (count-triplets nums2 nums1)))