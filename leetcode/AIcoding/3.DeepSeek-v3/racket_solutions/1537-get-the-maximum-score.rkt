(define/contract (max-sum nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define mod 1000000007)
  (define (solve nums1 nums2)
    (let loop ([i 0] [j 0] [sum1 0] [sum2 0])
      (cond
        [(and (< i (length nums1)) (< j (length nums2)))
         (let ([x (list-ref nums1 i)] [y (list-ref nums2 j)])
           (cond
             [(< x y) (loop (add1 i) j (+ sum1 x) sum2)]
             [(> x y) (loop i (add1 j) sum1 (+ sum2 y))]
             [else (loop (add1 i) (add1 j) (max (+ sum1 x) (+ sum2 y)) (max (+ sum1 x) (+ sum2 y)))]))]
        [else
         (let ([sum1 (if (< i (length nums1)) 
                         (+ sum1 (apply + (drop nums1 i)))
                         sum1)]
               [sum2 (if (< j (length nums2))
                         (+ sum2 (apply + (drop nums2 j)))
                         sum2)])
           (modulo (max sum1 sum2) mod))])))
  (solve nums1 nums2))