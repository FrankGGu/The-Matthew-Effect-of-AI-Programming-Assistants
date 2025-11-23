(define (minimum-array-end nums)
  (let ((n (length nums)))
    (if (zero? n)
        0
        (let loop ((i 1) (min-val (first nums)))
          (if (= i n)
              min-val
              (loop (+ i 1) (min min-val (list-ref nums i))))))))