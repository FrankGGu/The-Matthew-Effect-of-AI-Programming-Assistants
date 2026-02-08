(define (minMovesToSpread(stones))
  (define (dfs stones moves)
    (if (and (= (apply + stones) (* 3 (length stones)))
             (for/all ([x stones]) (<= x 1)))
        moves
        (let loop ([i 0] [min-moves +inf.])
          (if (= i (length stones))
              min-moves
              (let* ([current (list-ref stones i)]
                     [next-stones (vector->list (vector->list (list->vector stones)))]
                     [new-moves (if (> current 1)
                                    (let ([added (min current 2)])
                                      (vector-set! next-stones i (- current added))
                                      (for ([j (in-range (length stones))])
                                        (when (not (= i j))
                                          (let ([to-add (min 1 (- 2 (list-ref next-stones j)))])
                                            (when (> to-add 0)
                                              (vector-set! next-stones j (+ (list-ref next-stones j) to-add))))))
                                      (if (not (equal? next-stones stones))
                                          (dfs next-stones (+ moves 1))
                                          +inf.))
                                    +inf.))])
                (loop (+ i 1) (min min-moves new-moves))))))
  (dfs stones 0))