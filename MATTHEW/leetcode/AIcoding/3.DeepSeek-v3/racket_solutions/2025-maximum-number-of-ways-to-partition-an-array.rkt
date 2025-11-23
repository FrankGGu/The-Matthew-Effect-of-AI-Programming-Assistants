(define/contract (ways-to-partition nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [prefix (make-vector (add1 n) 0)]
         [total (foldl + 0 nums)])
    (for ([i (in-range n)])
      (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (list-ref nums i))))
    (let loop ([i 1]
               [left (hash)]
               [right (for/hash ([j (in-range 1 n)])
                         (values (vector-ref prefix j) (add1 (hash-ref right (vector-ref prefix j) 0))))]
               [res (hash-ref right (quotient total 2) 0)])
      (if (>= i n)
          res
          (let* ([old (vector-ref prefix i)]
                 [new (+ old (- k (list-ref nums (sub1 i))))]
                 [total-new (+ total (- k (list-ref nums (sub1 i))))]
                 [res-new (max res
                               (+ (hash-ref left (quotient total-new 2) 0)
                               (hash-ref right (- (quotient total-new 2) new) 0)))])
            (loop (add1 i)
                  (hash-update left old add1 (lambda () 0))
                  (hash-update right old sub1 (lambda () 0))
                  res-new))))))