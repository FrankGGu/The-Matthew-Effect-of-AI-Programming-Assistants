(define (count-almost-equal-pairs-ii nums1 nums2)
  (let* ([n (vector-length nums1)]
         [counts (make-hash)]
         [total-pairs 0])
    (for ([i (in-range n)])
      (let* ([x (vector-ref nums1 i)]
             [y (vector-ref nums2 i)])
        (let ([current-pairs 0])
          (for* ([dx '(-1 0 1)]
                 [dy '(-1 0 1)])
            (let ([target-x (+ x dx)]
                  [target-y (+ y dy)])
              (set! current-pairs (+ current-pairs (hash-ref counts (list target-x target-y) 0)))))
          (set! total-pairs (+ total-pairs current-pairs)))
        (hash-set! counts (list x y) (add1 (hash-ref counts (list x y) 0)))))
    total-pairs))