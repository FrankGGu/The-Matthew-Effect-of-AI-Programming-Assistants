(define (max-score-sightseeing-pair values)
  (let* ([n (length values)]
         [v0 (car values)])
    (car
     (for/fold ([max-score -1000000000] ; A sufficiently small initial score
                [max-val-i-plus-i v0]) ; values[0] + 0
               ([val-j (in-list (cdr values))]
                [j (in-range 1 n)])
       (let* ([current-score (+ max-val-i-plus-i val-j (- j))]
              [new-max-score (max max-score current-score)]
              [new-max-val-i-plus-i (max max-val-i-plus-i (+ val-j j))])
         (list new-max-score new-max-val-i-plus-i))))))