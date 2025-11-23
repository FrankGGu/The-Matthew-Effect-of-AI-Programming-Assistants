#lang racket

(define/contract (max-score-sightseeing pairs)
  (-> (listof (cons/c exact-integer? exact-integer?)) exact-integer?)
  (let loop ([i 0] [max-prev -inf.0] [max-score -inf.0])
    (if (= i (length pairs))
        max-score
        (let* ([pair (list-ref pairs i)]
               [val (car pair)]
               [score (+ (- val 1) max-prev)])
          (loop (+ i 1) (max max-prev (- val 1)) (max max-score score))))))