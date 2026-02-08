(define (build-array target n)
  (let loop ((i 1) (j 0) (res '()))
    (cond
      [(> i n) (reverse res)]
      [(= j (length target)) (reverse res)]
      [(= i (list-ref target j)) (loop (+ i 1) (+ j 1) (cons "Push" res))]
      [else (loop (+ i 1) j (cons "Pop" (cons "Push" res)))])))