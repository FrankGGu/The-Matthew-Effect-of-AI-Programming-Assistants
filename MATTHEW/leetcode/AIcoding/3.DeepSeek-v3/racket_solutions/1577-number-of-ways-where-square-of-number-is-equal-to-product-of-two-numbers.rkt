(define/contract (num-triplets nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define (count-triples nums1 nums2)
    (define freq (make-hash))
    (for* ([a (in-list nums1)]
           [b (in-list nums1)]
           #:when (>= b a))
      (hash-update! freq (* a b) add1 0))
    (define res 0)
    (for ([c (in-list nums2)])
      (set! res (+ res (hash-ref freq (* c c) 0))))
    res)
  (+ (count-triples nums1 nums2) (count-triples nums2 nums1)))