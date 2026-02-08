(define (common-factors a b)
  (let loop ([i 1] [count 0])
    (cond
      [(> i (min a b)) count]
      [(= (remainder a i) 0)
       (if (= (remainder b i) 0)
           (loop (+ i 1) (+ count 1))
           (loop (+ i 1) count))]
      [else (loop (+ i 1) count)])))