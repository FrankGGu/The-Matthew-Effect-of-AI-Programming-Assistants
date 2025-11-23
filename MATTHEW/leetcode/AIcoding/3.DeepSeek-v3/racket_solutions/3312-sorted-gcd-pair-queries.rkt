(define/contract (handle-query nums1 nums2 queries)
  (-> (listof exact-integer?) (listof exact-integer?) (listof (listof exact-integer?)) (listof exact-integer?))
  (define n (length nums1))
  (define m (length queries))
  (define result '())
  (for ([query queries])
    (match query
      [(list 1 l r)
       (for ([i (in-range (- l 1) r)])
         (set! nums1 (list-set nums1 i (gcd (list-ref nums1 i) (list-ref nums2 i)))))]
      [(list 2 l r)
       (for ([i (in-range (- l 1) r)])
         (set! nums2 (list-set nums2 i (gcd (list-ref nums1 i) (list-ref nums2 i))))]
      [(list 3)
       (set! result (cons (apply + nums1) result))]))
  (reverse result))