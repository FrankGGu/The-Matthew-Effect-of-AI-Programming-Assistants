(define (continuous-subarrays nums)
  (let loop ([i 0] [count 0])
    (if (= i (length nums))
        count
        (let loop2 ([j i] [min-val (list-ref nums i)] [max-val (list-ref nums i)])
          (if (= j (length nums))
              (loop (+ i 1) (+ count (- j i)))
              (let* ([curr (list-ref nums j)]
                     [new-min (min min-val curr)]
                     [new-max (max max-val curr)]
                     [diff (- new-max new-min)])
                (if (<= diff 2)
                    (loop2 (+ j 1) new-min new-max)
                    (loop (+ i 1) (+ count (- j i))))))))))