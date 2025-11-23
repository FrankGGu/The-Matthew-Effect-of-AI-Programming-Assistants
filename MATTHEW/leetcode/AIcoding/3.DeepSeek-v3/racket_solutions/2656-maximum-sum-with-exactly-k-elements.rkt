(define (maximize-sum nums k)
  (let* ([max-num (apply max nums)]
         [sum (* max-num k)]
         [additional (/ (* (- k 1) k) 2)])
    (+ sum additional)))