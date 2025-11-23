(define (consecutive-numbers-sum n)
  (let loop ([k 2] [count 1])
    (if (> k (sqrt (* 2 n)))
        count
        (let ([num (- n (* k (- k 1)) (/ 2))])
          (if (and (> num 0) (= (modulo num k) 0))
              (loop (+ k 1) (+ count 1))
              (loop (+ k 1) count))))))