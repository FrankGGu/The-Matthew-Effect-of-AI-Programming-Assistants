(define/contract (max-score-sightseeing-pair values)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [max-prev (- (first values) 1)] [max-score 0])
    (if (>= i (length values))
        max-score
        (let ([current-score (+ max-prev (list-ref values i))])
          (loop (add1 i)
                (max max-prev (list-ref values i) (- i))
                (max max-score current-score))))))