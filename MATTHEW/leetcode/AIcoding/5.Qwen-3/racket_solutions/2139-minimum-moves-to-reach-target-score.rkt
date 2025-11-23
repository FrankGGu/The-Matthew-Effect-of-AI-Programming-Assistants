(define/contract (min-moves target)
  (-> exact-integer? exact-integer?)
  (let loop ([score 0] [moves 0])
    (if (>= score target)
        moves
        (loop (+ score (if (= (modulo score 2) 0) 1 2)) (+ moves 1)))))