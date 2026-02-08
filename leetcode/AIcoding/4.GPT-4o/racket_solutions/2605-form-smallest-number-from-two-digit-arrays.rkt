(define (min-number nums1 nums2)
  (let* ([set1 (set nums1)]
         [set2 (set nums2)]
         [common (set-intersection set1 set2)]
         [min-common (if (set-empty? common) #f (set-min common))])
    (if min-common
        (number->string min-common)
        (let ([min1 (if (set-empty? set1) #f (set-min set1))]
              [min2 (if (set-empty? set2) #f (set-min set2))])
          (if (and min1 min2)
              (if (< min1 min2)
                  (string-append (number->string min1) (number->string min2))
                  (string-append (number->string min2) (number->string min1))
              )
              (if min1
                  (number->string min1)
                  (number->string min2)))))))