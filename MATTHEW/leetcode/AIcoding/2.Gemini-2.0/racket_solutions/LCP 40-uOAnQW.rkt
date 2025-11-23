(define (card-points cards k)
  (define n (length cards))
  (define (sum lst) (foldl + 0 lst))
  (define (max-score cards k current-score)
    (if (= k 0)
        current-score
        (max (max-score (drop cards 1) (- k 1) (+ current-score (car cards)))
             (max-score (drop-right cards 1) (- k 1) (+ current-score (last cards))))))
  (max-score cards k 0))