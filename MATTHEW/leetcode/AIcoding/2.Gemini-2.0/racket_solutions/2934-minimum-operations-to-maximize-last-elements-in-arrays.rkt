(define (min-operations nums1 nums2)
  (define (solve target)
    (let loop ([i 0] [ops 0])
      (cond
        [(= i (length nums1)) ops]
        [(= (vector-ref nums1 i) target) (loop (+ i 1) ops)]
        [(= (vector-ref nums2 i) target) (loop (+ i 1) (+ ops 1))]
        [else (if (or (= (vector-ref nums1 i) (vector-ref nums2 (- (length nums1) 1)))
                         (= (vector-ref nums2 i) (vector-ref nums2 (- (length nums1) 1))))
                  (loop (+ i 1) (+ ops 1))
                  #f)])))

  (let ([n (- (length nums1) 1)]
        [target (vector-ref nums2 n)])
    (let ([res1 (solve target)])
      (if res1
          res1
          (let ([temp1 (vector-ref nums1 n)])
            (set! target temp1)
            (let ([res2 (solve target)])
              (if res2
                  (+ res2 1)
                  -1)))))))