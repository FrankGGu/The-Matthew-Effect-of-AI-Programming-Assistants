(define/contract (merge-arrays nums1 nums2)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let loop ([i 0] [j 0] [result '()])
    (cond
      [(and (>= i (length nums1)) (>= j (length nums2))) (reverse result)]
      [(>= i (length nums1)) (loop i (add1 j) (cons (list-ref nums2 j) result))]
      [(>= j (length nums2)) (loop (add1 i) j (cons (list-ref nums1 i) result))]
      [else
       (let ([id1 (car (list-ref nums1 i))]
             [id2 (car (list-ref nums2 j))])
         (cond
           [(< id1 id2) (loop (add1 i) j (cons (list-ref nums1 i) result))]
           [(> id1 id2) (loop i (add1 j) (cons (list-ref nums2 j) result))]
           [else (loop (add1 i) (add1 j) (cons (list id1 (+ (cadr (list-ref nums1 i)) (cadr (list-ref nums2 j)))) result)]))])))