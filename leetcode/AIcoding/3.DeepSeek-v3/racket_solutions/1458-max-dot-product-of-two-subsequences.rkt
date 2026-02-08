(define/contract (max-dot-product nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([m (length nums1)]
         [n (length nums2)]
         [dp (make-vector (add1 m) (make-vector (add1 n) -inf.0))])
    (for ([i (in-range 1 (add1 m))])
      (for ([j (in-range 1 (add1 n))])
        (let ([product (* (list-ref nums1 (sub1 i)) (list-ref nums2 (sub1 j)))])
          (vector-set! (vector-ref dp i) j 
                       (max product
                            (+ product (vector-ref (vector-ref dp (sub1 i)) (sub1 j)))
                            (vector-ref (vector-ref dp (sub1 i)) j)
                            (vector-ref (vector-ref dp i) (sub1 j)))))))
    (vector-ref (vector-ref dp m) n)))