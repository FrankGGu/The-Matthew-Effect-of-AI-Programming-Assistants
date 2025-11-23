(define (max-chunks-to-sorted arr)
  (let loop ([i 0] [max-val 0] [chunks 0])
    (if (= i (length arr))
        chunks
        (let ([new-max (max max-val (list-ref arr i))])
          (if (= new-max i)
              (loop (+ i 1) new-max (+ chunks 1))
              (loop (+ i 1) new-max chunks))))))