(define (missing-rolls rolls n mean)
  (let* ([m (length rolls)]
         [sum-rolls (apply + rolls)]
         [total-sum (* mean (+ m n))]
         [missing-sum (- total-sum sum-rolls)])
    (cond
      [(or (< missing-sum n) (> missing-sum (* 6 n))) '()]
      [else
       (let* ([base (quotient missing-sum n)]
              [rem (remainder missing-sum n)]
              [res (make-list n base)])
         (for ([i (in-range rem)])
           (list-set res i (add1 (list-ref res i)))
         res))])))