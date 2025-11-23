(define (pivotInteger n)
  (let loop ((i 1) (sum1 0) (sum2 (/ (* n (+ n 1)) 2)))
    (if (> i n)
        -1
        (begin
          (set! sum1 (+ sum1 i))
          (set! sum2 (- sum2 i))
          (if (= sum1 sum2)
              i
              (loop (+ i 1) sum1 sum2))))))