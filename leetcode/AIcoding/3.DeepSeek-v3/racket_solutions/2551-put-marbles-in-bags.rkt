(define/contract (put-marbles weights k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (if (= k 1)
      0
      (let* ([n (length weights)]
             [splits (make-list (- n 1) 0)]
             [splits (for/list ([i (in-range (- n 1))])
                       (+ (list-ref weights i) (list-ref weights (+ i 1))))]
             [sorted-splits (sort splits <)])
        (- (apply + (take (reverse sorted-splits) (- k 1)))
           (apply + (take sorted-splits (- k 1)))))))