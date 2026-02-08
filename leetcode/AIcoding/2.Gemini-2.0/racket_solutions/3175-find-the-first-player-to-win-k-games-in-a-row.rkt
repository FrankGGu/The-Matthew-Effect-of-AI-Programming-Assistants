(define (get-winner arr k)
  (let loop ([winner (first arr)]
             [streak 0]
             [rest (rest arr)])
    (cond
      [(empty? rest) winner]
      [(= k streak) winner]
      [(> winner (first rest))
       (loop winner (+ 1 streak) (rest rest))]
      [else
       (loop (first rest) 1 (rest rest))])))