(define-class
  FindSumPairs
  (init-field
    (nums1 (list))
    (nums2 (list)))

  (define nums1-hash (make-hash))
  (for ([num (in-list nums1)])
    (hash-update! nums1-hash num add1 0)

  (define nums2-hash (make-hash))
  (for ([num (in-list nums2)])
    (hash-update! nums2-hash num add1 0)

  (define nums2-list nums2)

  (define/public (add index val)
    (define old-val (list-ref nums2-list index))
    (hash-update! nums2-hash old-val sub1)
    (define new-val (+ old-val val))
    (list-set! nums2-list index new-val)
    (hash-update! nums2-hash new-val add1 0))

  (define/public (count tot)
    (for/sum ([(num cnt) (in-hash nums1-hash)])
      (* cnt (hash-ref nums2-hash (- tot num) 0))))