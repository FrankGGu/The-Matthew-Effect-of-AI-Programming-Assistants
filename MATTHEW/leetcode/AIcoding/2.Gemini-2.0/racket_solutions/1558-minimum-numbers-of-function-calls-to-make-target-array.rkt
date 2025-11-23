(define (min-operations nums)
  (let loop ([nums nums] [ops 0] [max-val (apply max nums)])
    (cond
      [(= max-val 0) ops]
      [else (let* ([odd-indices (filter (lambda (i) (odd? (list-ref nums i))) (range (length nums))))
                   (new-nums (map (lambda (x) (quotient x 2)) nums))]
              (loop new-nums (+ ops (if (empty? odd-indices) 1 (+ 1 (length odd-indices)))) (apply max new-nums)))))))