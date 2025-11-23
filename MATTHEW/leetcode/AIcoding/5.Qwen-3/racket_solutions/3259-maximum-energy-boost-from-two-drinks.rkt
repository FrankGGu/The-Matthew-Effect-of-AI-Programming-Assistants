(define/contract (max-boost energy)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [prev 0] [curr 0])
    (if (= i (length energy))
        curr
        (loop (+ i 1) curr (+ curr (if (>= prev 0) (max 0 (- (list-ref energy i) prev)) 0))))))