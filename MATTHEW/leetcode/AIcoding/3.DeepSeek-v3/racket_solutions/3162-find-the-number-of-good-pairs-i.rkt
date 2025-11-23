(define/contract (number-of-pairs nums1 nums2 k)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([i 0] [j 0] [count 0])
    (cond
      [(>= i (length nums1)) count]
      [(>= j (length nums2))
       (loop (add1 i) 0 count)]
      [(zero? (modulo (list-ref nums1 i) (* (list-ref nums2 j) k)))
       (loop i (add1 j) (add1 count))]
      [else (loop i (add1 j) count)])))