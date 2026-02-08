(define (kth-smallest-product nums1 nums2 k)
  (define (count-less-equal x)
    (let loop ([i 0] [j (- (length nums2) 1)] [count 0])
      (cond
        [(or (= i (length nums1)) (< j 0)) count]
        [(< (* (list-ref nums1 i) (list-ref nums2 j)) x)
         (loop (+ i 1) j (+ count (+ j 1)))]
        [else
         (loop i (- j 1) count)])))

  (define (binary-search low high)
    (if (>= low high)
        low
        (let ([mid (quotient (+ low high) 2)])
          (if (>= (count-less-equal mid) k)
              (binary-search low mid)
              (binary-search (+ mid 1) high)))))

  (let ([min-val (* (list-ref nums1 0) (list-ref nums2 0))]
        [max-val (* (list-ref nums1 (- (length nums1) 1)) (list-ref nums2 (- (length nums2) 1)))]
        [min-neg (* (list-ref nums1 0) (list-ref nums2 (- (length nums2) 1)))]
        [max-neg (* (list-ref nums1 (- (length nums1) 1)) (list-ref nums2 0))])
    (binary-search (min min-val min-neg max-neg max-val) (max min-val min-neg max-neg max-val))))