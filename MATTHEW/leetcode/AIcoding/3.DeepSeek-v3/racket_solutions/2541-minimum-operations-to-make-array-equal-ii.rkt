(define (min-operations nums1 nums2 k)
  (let loop ([i 0]
             [sum-diff 0]
             [ops 0])
    (cond
      [(= i (length nums1)) (if (zero? sum-diff) ops -1)]
      [else
       (let ([diff (- (list-ref nums1 i) (list-ref nums2 i))])
         (if (zero? k)
             (if (zero? diff) (loop (add1 i) sum-diff ops) -1)
             (if (zero? (modulo diff k))
                 (let ([delta (quotient diff k)])
                   (loop (add1 i) (+ sum-diff delta) (+ ops (abs delta))))
                 -1)))])))