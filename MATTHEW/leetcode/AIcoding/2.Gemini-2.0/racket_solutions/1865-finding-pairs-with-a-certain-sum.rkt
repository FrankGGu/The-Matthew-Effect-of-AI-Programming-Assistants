(define class:FindSumPairs%
  (class object%
    (init nums1 nums2)
    (define/public nums1 nums1)
    (define/public nums2 nums2)
    (define/public nums2-freq (make-hash))
    (define/public initialize
      (begin
        (for ([num (in-list nums2)])
          (hash-update! nums2-freq num (λ (x) (+ x 1)) 1))))
    (define/public add
      (λ (index val)
        (let* ([old-val (list-ref nums2 index)])
          (hash-update! nums2-freq old-val (λ (x) (- x 1)))
          (when (= (hash-ref nums2-freq old-val) 0)
            (hash-remove! nums2-freq old-val))
          (set! nums2 (list-set nums2 index (+ old-val val)))
          (hash-update! nums2-freq (+ old-val val) (λ (x) (+ x 1)) 1))))
    (define/public count
      (λ (tot)
        (let ([count 0])
          (for ([num (in-list nums1)])
            (let ([needed (- tot num)])
              (when (hash-has-key? nums2-freq needed)
                (set! count (+ count (hash-ref nums2-freq needed))))))
          count)))
    (initialize)))

(define FindSumPairs
  (λ (nums1 nums2)
    (new class:FindSumPairs% [nums1 nums1] [nums2 nums2])))