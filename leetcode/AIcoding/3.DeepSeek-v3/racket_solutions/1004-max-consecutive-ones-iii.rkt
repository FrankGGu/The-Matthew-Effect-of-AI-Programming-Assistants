(define/contract (longest-ones nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([left 0] [right 0] [zeros 0] [max-len 0])
    (cond
      [(>= right (length nums)) max-len]
      [(zero? (list-ref nums right))
       (if (< zeros k)
           (loop left (add1 right) (add1 zeros) (max max-len (- (add1 right) left)))
           (loop (add1 left) right (if (zero? (list-ref nums left)) (sub1 zeros) zeros) max-len))]
      [else
       (loop left (add1 right) zeros (max max-len (- (add1 right) left)))])))