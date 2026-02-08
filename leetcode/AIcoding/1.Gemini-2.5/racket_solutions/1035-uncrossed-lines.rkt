(define (max-uncrossed-lines nums1 nums2)
  (define m (vector-length nums1))
  (define n (vector-length nums2))

  (define dp (make-vector (+ m 1)))
  (for ([i (in-range (+ m 1))])
    (vector-set! dp i (make-vector (+ n 1) 0)))

  (for ([i (in-range 1 (+ m 1))])
    (for ([j (in-range 1 (+ n 1))])
      (if (= (vector-ref nums1 (- i 1)) (vector-ref nums2 (- j 1)))
          (vector-set! (vector-ref dp i) j (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1))))
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (- i 1)) j)
                                                 (vector-ref (vector-ref dp i) (- j 1)))))))

  (vector-ref (vector-ref dp m) n))