(define (merge nums1 m nums2 n)
  (let loop ((i m) (j n) (k (+ m n -1)))
    (cond
      [(< i 0) (for ([x (in-range j)]) (set! (vector-ref nums1 k) (vector-ref nums2 x)) (set! k (- k 1)))]
      [(< j 0) #t]
      [(> (vector-ref nums1 i) (vector-ref nums2 j))
       (set! (vector-ref nums1 k) (vector-ref nums1 i))
       (set! i (- i 1))
       (set! k (- k 1))
       (loop i j k)]
      [else
       (set! (vector-ref nums1 k) (vector-ref nums2 j))
       (set! j (- j 1))
       (set! k (- k 1))
       (loop i j k)])))