(define/contract (max-dist-to-closest seats)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [prev -1] [max-dist 0])
    (cond
      [(= i (length seats))
       (max max-dist (- (length seats) prev 1))]
      [(= (list-ref seats i) 1)
       (if (= prev -1)
           (loop (+ i 1) i (max max-dist i))
           (loop (+ i 1) i (max max-dist (quotient (- i prev) 2))))]
      [else
       (loop (+ i 1) prev max-dist)])))