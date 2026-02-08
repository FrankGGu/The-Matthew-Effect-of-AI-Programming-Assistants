(define (count-alternating-subarrays nums)
  (let loop ([i 1] [count 1] [total 1])
    (if (>= i (length nums))
        total
        (if (not (= (list-ref nums i) (list-ref nums (- i 1))))
            (loop (+ i 1) (+ count 1) (+ total count 1))
            (loop (+ i 1) 1 (+ total 1))))))