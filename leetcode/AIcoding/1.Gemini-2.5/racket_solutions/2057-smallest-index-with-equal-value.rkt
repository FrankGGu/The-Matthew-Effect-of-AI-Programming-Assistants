(define (smallest-equal-value nums)
  (let loop ((i 0))
    (if (>= i (length nums))
        -1
        (if (= (modulo i 10) (list-ref nums i))
            i
            (loop (+ i 1))))))