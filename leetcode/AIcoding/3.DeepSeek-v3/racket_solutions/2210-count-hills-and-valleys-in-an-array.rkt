(define (count-hill-valley nums)
  (let loop ([i 1] [prev (car nums)] [count 0])
    (if (>= i (sub1 (length nums)))
        count
        (let* ([current (list-ref nums i)]
               [next (list-ref nums (add1 i))]
               [is-hill (and (< prev current) (> next current))]
               [is-valley (and (> prev current) (< next current))])
          (if (or is-hill is-valley)
              (loop (add1 i) current (add1 count))
              (loop (add1 i) current count))))))