(define (max-distance nums1 nums2)
  (let* ([n1-len (vector-length nums1)]
         [n2-len (vector-length nums2)])
    (let loop ([i 0] [j 0] [max-dist 0])
      (cond
        [(or (>= i n1-len) (>= j n2-len)) max-dist]
        [(<= (vector-ref nums1 i) (vector-ref nums2 j))
         (loop i (+ j 1) (max max-dist (- j i)))]
        [else
         (loop (+ i 1) (max j (+ i 1)) max-dist)]))))