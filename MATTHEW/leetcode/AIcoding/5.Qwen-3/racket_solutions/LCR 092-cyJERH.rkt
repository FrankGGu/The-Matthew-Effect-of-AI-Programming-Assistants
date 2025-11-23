(define (halve-array nums)
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (if (even? (list-ref nums i))
            (loop (+ i 1) count)
            (loop (+ i 1) (+ count 1))))))