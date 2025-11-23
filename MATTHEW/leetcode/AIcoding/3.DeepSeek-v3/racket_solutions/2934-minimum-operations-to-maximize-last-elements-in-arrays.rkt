(define/contract (min-operations nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define n (length nums1))
  (define (helper x y)
    (let loop ([i 1] [count 0] [last1 (car x)] [last2 (car y)])
      (if (= i n)
          count
          (let ([a (list-ref x i)] [b (list-ref y i)])
            (cond
              [(and (<= last1 a) (<= last2 b)) (loop (add1 i) count a b)]
              [(and (<= last1 b) (<= last2 a)) (loop (add1 i) (add1 count) b a)]
              [else +inf.0])))))
  (let ([res1 (helper nums1 nums2)]
        [res2 (helper nums2 nums1)])
    (if (= res1 +inf.0)
        (if (= res2 +inf.0) -1 res2)
        (if (= res2 +inf.0) res1 (min res1 res2)))))