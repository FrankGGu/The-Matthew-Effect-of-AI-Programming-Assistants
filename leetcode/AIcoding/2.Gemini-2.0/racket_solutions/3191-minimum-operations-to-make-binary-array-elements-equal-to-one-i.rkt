(define (minOperations nums)
  (let loop ([nums nums] [count 0])
    (cond
      [(empty? nums) count]
      [(equal? (first nums) 0) (loop (rest nums) (+ count 1))]
      [else (loop (rest nums) count)])))