(define (min-moves nums k)
  (let* ([indices (for/list ([num nums] [i (in-naturals)] #:when (= num 1)) i)]
         [n (length indices)]
         [prefix (make-vector (+ n 1) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix (+ i 1) (+ (vector-ref prefix i) (list-ref indices i))))
    (let loop ([res +inf.0] [i 0] [j (- k 1)])
      (if (>= j n)
          res
          (let* ([mid (quotient (+ i j) 2)]
                 [radius (- mid i)]
                 [left (- (* (vector-ref prefix (+ mid 1)) (if (odd? k) 1 2))
                          (vector-ref prefix i)
                          (vector-ref prefix (+ j 1))
                          (vector-ref prefix (+ mid 1))
                          (* radius (+ radius 1)))]
                 [right (- (+ (vector-ref prefix (+ j 1)) (vector-ref prefix (+ mid 1)))
                          (* (vector-ref prefix (+ mid 1)) (if (odd? k) 1 2))
                          (vector-ref prefix i)
                          (* radius (+ radius 1)))]
                 [total (+ left right)])
            (loop (min res total) (+ i 1) (+ j 1)))))))