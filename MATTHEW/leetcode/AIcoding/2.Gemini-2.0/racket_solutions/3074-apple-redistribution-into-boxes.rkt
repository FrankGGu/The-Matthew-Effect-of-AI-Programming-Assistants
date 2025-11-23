(define (redistribute-apples apples boxes)
  (let ([avg (quotient apples boxes)]
        [rem (remainder apples boxes)])
    (let loop ([i 0] [result '()])
      (if (= i boxes)
          result
          (let ([num-apples (if (< i rem) (+ avg 1) avg)])
            (loop (+ i 1) (append result (list num-apples))))))))