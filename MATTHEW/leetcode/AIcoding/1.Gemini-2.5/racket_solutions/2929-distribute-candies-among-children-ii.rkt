(define (combinations-2 n)
  (if (< n 2)
      0
      (/ (* n (- n 1)) 2)))

(define (distribute-candies k limit)
  (let* ((n 3) ; Number of children is fixed at 3
         (limit-plus-1 (+ limit 1)) ; Helper for (limit + 1)

         ; Term 1: Total ways to distribute k candies among 3 children without upper bound (c_i >= 0)
         ; C(k + n - 1, n - 1) = C(k + 3 - 1, 3 - 1) = C(k + 2, 2)
         (term1 (combinations-2 (+ k 2)))

         ; Term 2: Ways where at least one child exceeds limit (c_i >= limit + 1)
         ; For one child, say c1, to exceed limit: c1' + c2 + c3 = k - (limit + 1)
         ; C(k - (limit + 1) + 2, 2)
         ; There are (3 choose 1) = 3 such terms
         (term2 (combinations-2 (+ (- k limit-plus-1) 2)))

         ; Term 3: Ways where at least two children exceed limit (c_i >= limit + 1, c_j >= limit + 1)
         ; For two children, say c1, c2, to exceed limit: c1' + c2' + c3 = k - 2*(limit + 1)
         ; C(k - 2*(limit + 1) + 2, 2)
         ; There are (3 choose 2) = 3 such terms
         (term3 (combinations-2 (+ (- k (* 2 limit-plus-1)) 2)))

         ; Term 4: Ways where all three children exceed limit (c1, c2, c3 >= limit + 1)
         ; For three children: c1' + c2' + c3' = k - 3*(limit + 1)
         ; C(k - 3*(limit + 1) + 2, 2)
         ; There are (3 choose 3) = 1 such term
         (term4 (combinations-2 (+ (- k (* 3 limit-plus-1)) 2))))

    ; Apply Principle of Inclusion-Exclusion: N(0) - N(A1) - N(A2) - N(A3) + N(A1A2) + N(A1A3) + N(A2A3) - N(A1A2A3)
    (+ term1
       (- (* 3 term2))
       (* 3 term3)
       (- term4))))