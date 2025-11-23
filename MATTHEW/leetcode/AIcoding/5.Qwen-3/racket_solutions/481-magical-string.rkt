(define (magical-string n)
  (if (<= n 0) 0
      (let ([s (vector 1 1 2)])
        (let loop ([i 2] [j 2] [count 3] [next 2])
          (if (>= count n) (vector-length s)
              (let ([new-val (if (= next 2) 1 2)])
                (if (< j (vector-length s))
                    (begin
                      (vector-set! s j new-val)
                      (loop (+ i 1) (+ j 1) (+ count 1) new-val))
                    (begin
                      (vector-set! s j new-val)
                      (loop (+ i 1) (+ j 1) (+ count 1) new-val)))))))))