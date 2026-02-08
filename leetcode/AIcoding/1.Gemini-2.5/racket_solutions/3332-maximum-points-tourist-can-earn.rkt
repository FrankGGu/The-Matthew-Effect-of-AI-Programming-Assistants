#lang racket

(define (max-score-sightseeing-pair values)
  (let* ([n (vector-length values)]
         [initial-max-score (+ (vector-ref values 0) (vector-ref values 1) 0 - 1)]
         [initial-max-ai-plus-i (+ (vector-ref values 0) 0)])
    (for/fold ([max-score initial-max-score]
               [max-ai-plus-i initial-max-ai-plus-i])
              ([j (in-range 2 n)])
      (let* ([current-val-j (vector-ref values j)]
             [score (+ max-ai-plus-i (- current-val-j j))]
             [new-max-score (max max-score score)]
             [new-max-ai-plus-i (max max-ai-plus-i (+ current-val-j j))])
        (values new-max-score new-max-ai-plus-i)))))