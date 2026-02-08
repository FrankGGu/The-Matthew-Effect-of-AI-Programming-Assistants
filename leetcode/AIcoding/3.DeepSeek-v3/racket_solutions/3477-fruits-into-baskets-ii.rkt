(define/contract (total-fruit fruits)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [max-count 0] [baskets (hash)] [fruits-list fruits])
    (if (>= right (length fruits-list))
        max-count
        (let* ([current-fruit (list-ref fruits-list right)]
               [new-baskets (hash-update baskets current-fruit add1 (lambda () 0))])
          (if (<= (hash-count new-baskets) 2)
              (loop left (add1 right) (max max-count (- (add1 right) left)) new-baskets fruits-list)
              (let* ([left-fruit (list-ref fruits-list left)]
                     [updated-baskets (hash-update new-baskets left-fruit sub1)]
                     [new-left (if (zero? (hash-ref updated-baskets left-fruit))
                                  (hash-remove updated-baskets left-fruit)
                                  updated-baskets)])
                (loop (add1 left) right max-count new-baskets fruits-list)))))))