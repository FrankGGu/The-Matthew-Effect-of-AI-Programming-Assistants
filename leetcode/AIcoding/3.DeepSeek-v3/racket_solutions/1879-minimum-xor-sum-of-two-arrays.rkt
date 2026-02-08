(define (minimum-xor-sum nums1 nums2)
  (let* ([n (length nums1)]
         [dp (make-vector (expt 2 n) +inf.0)]
         [nums1 (list->vector nums1)]
         [nums2 (list->vector nums2)])
    (vector-set! dp 0 0)
    (for ([mask (in-range 1 (expt 2 n))])
      (let ([count (bitwise-bit-count mask)])
        (for ([i (in-range n)])
          (when (bitwise-bit-set? mask i)
            (let ([prev-mask (bitwise-xor mask (expt 2 i))]
                  [current-val (bitwise-xor (vector-ref nums1 (sub1 count)) (vector-ref nums2 i))])
              (vector-set! dp mask (min (vector-ref dp mask)
                                       (+ (vector-ref dp prev-mask) current-val))))))))
    (vector-ref dp (sub1 (expt 2 n)))))