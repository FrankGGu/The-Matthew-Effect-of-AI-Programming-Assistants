(define/contract (find-indices nums indexDifference valueDifference)
  (-> (listof exact-integer?) exact-integer? exact-integer? (listof exact-integer?))
  (let loop ([i 0] [result '()])
    (cond
      [(>= i (length nums)) (reverse result)]
      [else
       (let loop2 ([j 0] [result result])
         (cond
           [(>= j (length nums)) (loop (add1 i) result)]
           [(and (>= (abs (- i j)) indexDifference)
                 (>= (abs (- (list-ref nums i) (list-ref nums j))) valueDifference))
            (loop (length nums) (cons j (cons i result)))]
           [else (loop2 (add1 j) result)]))])))