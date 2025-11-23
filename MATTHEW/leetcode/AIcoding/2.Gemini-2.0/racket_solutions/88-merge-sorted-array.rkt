(define (merge nums1 m nums2 n)
  (let loop ((i (- m 1)) (j (- n 1)) (k (- (+ m n) 1)))
    (cond
      ((< j 0) (void))
      ((< i 0) (for ((l (in-range 0 (+ j 1)))) (set! (vector-ref nums1 l) (vector-ref nums2 l))))
      ((>= (vector-ref nums1 i) (vector-ref nums2 j))
       (set! (vector-ref nums1 k) (vector-ref nums1 i))
       (loop (- i 1) j (- k 1)))
      (else
       (set! (vector-ref nums1 k) (vector-ref nums2 j))
       (loop i (- j 1) (- k 1))))))