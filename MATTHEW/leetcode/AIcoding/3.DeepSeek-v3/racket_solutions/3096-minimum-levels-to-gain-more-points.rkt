(define (minimum-levels possible)
  (let loop ([i 1]
             [sum1 0]
             [sum2 (apply + (map (lambda (x) (if (= x 1) 1 -1)) possible))])
    (if (>= i (length possible))
        -1
        (let* ([current (list-ref possible (- i 1))]
               [new-sum1 (+ sum1 (if (= current 1) 1 -1))]
               [new-sum2 (- sum2 (if (= current 1) 1 -1))])
          (if (> new-sum1 new-sum2)
              i
              (loop (+ i 1) new-sum1 new-sum2))))))