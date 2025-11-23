(define (kSmallestPairs nums1 nums2 k)
  (define (compare-pairs pair1 pair2)
    (let ([sum1 (+ (car pair1) (cadr pair1))])
      (let ([sum2 (+ (car pair2) (cadr pair2))])
        (if (< sum1 sum2) -1
            (if (> sum1 sum2) 1
                (if (< (car pair1) (car pair2)) -1
                    (if (> (car pair1) (car pair2)) 1 0)))))))

  (define pairs '())
  (for ([x nums1]
        [y nums2])
    (set! pairs (cons (list x y) pairs)))
  (set! pairs (sort pairs compare-pairs))
  (take pairs (min k (length pairs))))