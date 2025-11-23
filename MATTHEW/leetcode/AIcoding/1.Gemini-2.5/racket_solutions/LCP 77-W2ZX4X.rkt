(define (find-maximum-number-of-elements-after-k-decrements nums k)
  (let* ([n (length nums)]
         [sorted-nums (sort nums >)]) ; Sort in descending order
    (let loop ([i 0] [max-x 0])
      (if (< i n)
          (let ([current-x (+ i 1)])
            (if (>= (list-ref sorted-nums i) current-x)
                (loop (+ i 1) current-x)
                (loop (+ i 1) max-x)))
          max-x))))