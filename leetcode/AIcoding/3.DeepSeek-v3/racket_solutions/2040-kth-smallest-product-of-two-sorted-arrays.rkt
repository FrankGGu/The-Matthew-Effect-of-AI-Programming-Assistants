(define (kth-smallest-product nums1 nums2 k)
  (define (count-less-or-equal x)
    (let loop ([i 0] [j (sub1 (length nums2))] [count 0])
      (if (or (>= i (length nums1)) (< j 0))
          count
          (let ([prod (* (list-ref nums1 i) (list-ref nums2 j))])
            (if (<= prod x)
                (loop (add1 i) j (+ count (add1 j)))
                (loop i (sub1 j) count))))))

  (let ([left (- (abs (apply min (append nums1 nums2))) 1)]
        [right (abs (apply max (append nums1 nums2)))])
    (let binary-search ([low (* -1 right right)]
                        [high (* right right)])
      (if (>= low high)
          low
          (let ([mid (quotient (+ low high) 2)])
            (if (>= (count-less-or-equal mid) k)
                (binary-search low mid)
                (binary-search (add1 mid) high)))))))