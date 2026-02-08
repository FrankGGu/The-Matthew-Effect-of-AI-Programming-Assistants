(define (bag-of-tokens tokens power)
  (let loop ([tokens (sort tokens <)]
             [power power]
             [score 0]
             [max-score 0])
    (cond
      [(empty? tokens) max-score]
      [(>= power (first tokens))
       (loop (rest tokens)
             (- power (first tokens))
             (+ score 1)
             (max max-score (+ score 1)))]
      [(> score 0)
       (loop (reverse (rest (reverse tokens)))
             (+ power (last tokens))
             (- score 1)
             (max max-score score))]
      [else max-score])))