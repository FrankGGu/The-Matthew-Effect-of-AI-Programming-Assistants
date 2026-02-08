(define (sum-of-beauties nums)
  (let* ([n (length nums)]
         [left-max (make-vector n 0)]
         [right-min (make-vector n 0)])
    (vector-set! left-max 0 (list-ref nums 0))
    (for ([i (in-range 1 n)])
      (vector-set! left-max i (max (vector-ref left-max (- i 1)) (list-ref nums i))))
    (vector-set! right-min (- n 1) (list-ref nums (- n 1)))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! right-min i (min (vector-ref right-min (+ i 1)) (list-ref nums i))))
    (let loop ([i 1]
               [sum 0])
      (if (>= i (- n 1))
          sum
          (let ([num (list-ref nums i)])
            (cond
              [(and (> num (vector-ref left-max (- i 1))) (< num (vector-ref right-min (+ i 1)))) (loop (+ i 1) (+ sum 2))]
              [(and (> num (list-ref nums (- i 1))) (< num (list-ref nums (+ i 1)))) (loop (+ i 1) (+ sum 1))]
              [else (loop (+ i 1) sum)]))))))