(define (countNonDecreasingSubarrays nums k)
  (define (count subarr)
    (define len (length subarr))
    (if (= len 0) 0
        (+ len (count (cdr subarr)))))

  (define (valid-subarrays start end)
    (let loop ((i start) (count 0))
      (if (>= i end) count
          (if (and (< i end) (or (= i start) (<= (list-ref nums i) (list-ref nums (- i 1)))))
              (loop (+ i 1) (+ count 1))
              (loop (+ i 1) count)))))

  (define (process i)
    (let ((j i))
      (while (and (< j (length nums)) (> k 0))
        (if (or (>= j (length nums)) (>= (+ j 1) (length nums)))
            (begin
              (set! k 0)
              (set! j (length nums)))
            (if (>= (list-ref nums j) (if (= j 0) -inf.0 (list-ref nums (- j 1))))
                (begin
                  (set! j (+ j 1)))
                (begin
                  (set! k (- k 1))
                  (if (< k 0)
                      (begin
                        (set! j (length nums))
                        (set! k 0)))))))
      (- j i)))

  (let loop ((i 0) (total 0))
    (if (>= i (length nums)) total
        (loop (+ i 1) (+ total (process i))))))