(define/contract (lexicographically-smallest-array nums limit)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [indices (build-list n (lambda (x) x))]
         [sorted-indices (sort indices (lambda (i j) (< (vector-ref nums-vec i) (vector-ref nums-vec j))))]
    (let loop ([i 0])
      (if (< i n)
          (let ([j i])
            (let inner-loop ([j j])
              (if (and (< (add1 j) n)
                      (<= (- (vector-ref nums-vec (list-ref sorted-indices (add1 j)))
                           (vector-ref nums-vec (list-ref sorted-indices j)))
                          limit))
                  (inner-loop (add1 j))
                  (let ([group (take (drop sorted-indices i) (- (add1 j) i))])
                    (let ([sorted-group (sort group <)])
                      (for ([k (in-range i (add1 j))])
                        (vector-set! nums-vec
                                     (list-ref sorted-indices k)
                                     (list-ref nums (list-ref sorted-group (- k i)))))
                      (loop (add1 j))))))
            (loop (add1 i)))
          (vector->list nums-vec)))))