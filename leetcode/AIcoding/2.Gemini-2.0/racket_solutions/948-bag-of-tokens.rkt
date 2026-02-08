(define (bag-of-tokens tokens power)
  (define (solve tokens power score)
    (cond
      [(empty? tokens) score]
      [else
       (let* ([sorted-tokens (sort tokens <)]
              [min-token (first sorted-tokens)]
              [max-token (last sorted-tokens)])
         (cond
           [(>= power min-token)
            (solve (rest sorted-tokens) (- power min-token) (+ score 1))]
           [(and (> score 0) (> (length sorted-tokens) 1))
            (solve (drop-right sorted-tokens 1) (+ power max-token) (- score 1))]
           [else score]))]))
  (solve tokens power 0))