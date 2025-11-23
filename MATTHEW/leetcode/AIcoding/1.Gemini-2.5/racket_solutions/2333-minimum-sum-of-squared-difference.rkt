(define (min-sum-sq-diff nums1 nums2 k1 k2)
  (let* ([n (length nums1)]
         [k-total (+ k1 k2)]
         [diff-counts (make-hash)]
         [max-diff 0]
         [nums1-vec (list->vector nums1)]
         [nums2-vec (list->vector nums2)])

    (for ([i (in-range n)])
      (let* ([val1 (vector-ref nums1-vec i)]
             [val2 (vector-ref nums2-vec i)]
             [diff (abs (- val1 val2))])
        (hash-set! diff-counts diff (+ (hash-ref diff-counts diff 0) 1))
        (set! max-diff (max max-diff diff))))

    (let loop ([d max-diff] [k-rem k-total])
      (when (and (> d 0) (> k-rem 0))
        (let ([current-count (hash-ref diff-counts d 0)])
          (if (> current-count 0)
              (if (>= k-rem current-count)
                  (begin
                    (hash-set! diff-counts d 0)
                    (hash-set! diff-counts (- d 1) (+ (hash-ref diff-counts (- d 1) 0) current-count))
                    (loop (- d 1) (- k-rem current-count)))
                  (begin
                    (hash-set! diff-counts d (- current-count k-rem))
                    (hash-set! diff-counts (- d 1) (+ (hash-ref diff-counts (- d 1) 0) k-rem))
                    )))
              (loop (- d 1) k-rem))))

    (let ([total-sum-sq 0])
      (for ([(diff count) (in-hash diff-counts)])
        (set! total-sum-sq (+ total-sum-sq (* count diff diff))))
      total-sum-sq)))