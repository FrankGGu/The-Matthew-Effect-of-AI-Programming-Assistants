(define/contract (num-moves-stones a b c)
  (-> exact-integer? exact-integer? exact-integer? (listof exact-integer?))
  (let* ([sorted (sort (list a b c) <)]
         [x (first sorted)]
         [y (second sorted)]
         [z (third sorted)]
         [min-moves (cond [(and (= (- y x) 1) (= (- z y) 1)) 0]
                          [(or (<= (- y x) 2) (<= (- z y) 2)) 1]
                          [else 2])]
         [max-moves (- (- z x) 2)])
    (list min-moves max-moves)))