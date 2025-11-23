(define (construct2d-array original m n)
  (cond
    [(or (< (length original) (* m n)) (< m 0) (< n 0)) '()]
    [else
     (let loop ([i 0] [result '()])
       (if (= i m)
           result
           (loop (+ i 1) (append result (list (list->vector (take (drop original (* i n)) n)))))))]))