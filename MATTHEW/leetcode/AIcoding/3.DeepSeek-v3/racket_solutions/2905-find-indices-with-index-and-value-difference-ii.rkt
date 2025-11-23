(define/contract (find-indices nums indexDifference valueDifference)
  (-> (listof exact-integer?) exact-integer? exact-integer? (listof exact-integer?))
  (let loop ([i 0] [j 0] [n (length nums)] [result '(-1 -1)])
    (cond
      [(>= i n) result]
      [(>= j n) (loop (add1 i) 0 n result)]
      [(and (>= (abs (- i j)) indexDifference)
            (>= (abs (- (list-ref nums i) (list-ref nums j))) valueDifference))
       (list i j)]
      [else (loop i (add1 j) n result)])))