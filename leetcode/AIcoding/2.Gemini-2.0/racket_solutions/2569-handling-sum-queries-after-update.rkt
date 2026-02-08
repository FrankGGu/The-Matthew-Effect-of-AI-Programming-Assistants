(define (handle-queries nums1 nums2 queries)
  (define n (vector-length nums1))
  (define sum-nums2 (box (apply + (vector->list nums2))))
  (define result '())
  (for ([q queries])
    (match q
      [(list 1 p x)
       (for ([i (in-range n)])
         (when (= i p)
           (vector-set! nums1 i (if (= x 0) 0 1))))]
      [(list 2 p)
       (box-set! sum-nums2 (+ (unbox sum-nums2) (* p (apply + (vector->list nums1)))))]
      [(list 3 _)
       (set! result (cons (unbox sum-nums2) result))]))
  (reverse result))