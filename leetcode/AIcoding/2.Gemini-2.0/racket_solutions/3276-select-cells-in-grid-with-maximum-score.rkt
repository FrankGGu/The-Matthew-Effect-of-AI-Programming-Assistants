(define (max-score-indices row col a)
  (let* ([m (length a)]
         [n (length (car a))]
         [score (lambda (i j)
                  (let ([up (for/sum ([k (in-range 0 i)]) (list-ref (list-ref a k) j))]
                        [down (for/sum ([k (in-range (add1 i) m)]) (list-ref (list-ref a k) j))]
                        [left (for/sum ([k (in-range 0 j)]) (list-ref (list-ref a i) k))]
                        [right (for/sum ([k (in-range (add1 j) n)]) (list-ref (list-ref a i) k))])
                  (+ up down left right)))]
         [scores (for*/list ([i (in-range m)]
                                 [j (in-range n)])
                            (list i j (score i j)))]
         [max-score (apply max (map third scores))]
         [result (sort (filter (lambda (x) (= (third x) max-score)) scores)
                       (lambda (a b)
                         (or (< (first a) (first b))
                             (and (= (first a) (first b))
                                  (< (second a) (second b))))))])
    (map (lambda (x) (list (first x) (second x))) result)))