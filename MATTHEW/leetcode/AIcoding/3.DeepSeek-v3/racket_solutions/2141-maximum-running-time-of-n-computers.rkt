(define/contract (max-run-time n batteries)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let* ([batteries (sort batteries >)]
         [total (apply + batteries)]
         [m (length batteries)])
    (let loop ([left 1] [right (quotient total n)])
      (if (> left right)
          right
          (let* ([mid (quotient (+ left right) 2)]
                 [sum (for/sum ([bat batteries]) (min bat mid))])
            (if (>= sum (* n mid))
                (loop (+ mid 1) right)
                (loop left (- mid 1))))))))