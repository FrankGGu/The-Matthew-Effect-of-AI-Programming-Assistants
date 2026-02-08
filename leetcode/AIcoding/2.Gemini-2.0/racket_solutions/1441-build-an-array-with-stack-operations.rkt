(define (build-array target n)
  (let loop ([i 1] [j 0] [res '()])
    (cond
      [(>= j (length target)) res]
      [(> i n) res]
      [(equal? i (list-ref target j))
       (loop (+ i 1) (+ j 1) (append res '("Push" "Pop")))]
      [(< i (list-ref target j))
       (loop (+ i 1) j (append res '("Push" "Pop")))]
      [else
       (loop (+ i 1) (+ j 1) (append res '("Push")))])))