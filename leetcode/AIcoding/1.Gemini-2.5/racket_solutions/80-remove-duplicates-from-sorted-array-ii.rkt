(define (remove-duplicates nums)
  (let* ((n (vector-length nums)))
    (if (<= n 2)
        n
        (let loop ((i 2)
                   (j 2))
          (if (< j n)
              (if (> (vector-ref nums j) (vector-ref nums (- i 2)))
                  (begin
                    (vector-set! nums i (vector-ref nums j))
                    (loop (+ i 1) (+ j 1)))
                  (loop i (+ j 1)))
              i)))))