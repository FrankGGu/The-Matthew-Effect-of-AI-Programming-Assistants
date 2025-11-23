(define/contract (merge nums1 m nums2 n)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?) exact-integer? void?)
  (let loop ([i (sub1 m)] [j (sub1 n)] [k (sub1 (+ m n))])
    (cond
      [(< j 0) (void)]
      [(and (>= i 0) (> (list-ref nums1 i) (list-ref nums2 j)))
       (list-set! nums1 k (list-ref nums1 i))
       (loop (sub1 i) j (sub1 k))]
      [else
       (list-set! nums1 k (list-ref nums2 j))
       (loop i (sub1 j) (sub1 k))])))