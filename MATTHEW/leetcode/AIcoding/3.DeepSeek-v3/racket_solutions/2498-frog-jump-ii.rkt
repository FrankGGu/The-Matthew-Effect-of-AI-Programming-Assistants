(define/contract (max-jump stones)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 1] [max-jump 0])
    (if (>= i (length stones))
        max-jump
        (loop (add1 i) (max max-jump (- (list-ref stones i) (list-ref stones (- i 1))))))))