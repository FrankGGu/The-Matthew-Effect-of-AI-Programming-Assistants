(define (find-length nums1 nums2)
  (let* ([n (vector-length nums1)]
         [m (vector-length nums2)]
         [dp (make-vector (+ n 1) (lambda () (make-vector (+ m 1) 0)))]
         [max-len 0])
    (for* ([i (in-range 1 (+ n 1))]
           [j (in-range 1 (+ m 1))])
      (when (= (vector-ref nums1 (- i 1)) (vector-ref nums2 (- j 1)))
        (let ([current-len (+ 1 (vector-ref (vector-ref dp (- i 1)) (- j 1)))])
          (vector-set! (vector-ref dp i) j current-len)
          (set! max-len (max max-len current-len)))))
    max-len))