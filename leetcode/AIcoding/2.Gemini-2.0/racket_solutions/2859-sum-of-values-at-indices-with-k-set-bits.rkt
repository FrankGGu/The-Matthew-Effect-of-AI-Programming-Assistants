(define (sum-indices-with-k-set-bits nums k)
  (let loop ([i 0] [sum 0])
    (if (= i (length nums))
        sum
        (let ([set-bits (count (lambda (x) (= x #\1)) (number->string i 2))])
          (if (= set-bits k)
              (loop (+ i 1) (+ sum (list-ref nums i)))
              (loop (+ i 1) sum))))))