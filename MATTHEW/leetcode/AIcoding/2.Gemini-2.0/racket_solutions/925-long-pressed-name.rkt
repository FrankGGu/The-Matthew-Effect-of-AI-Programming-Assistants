(define (is-long-pressed-name name typed)
  (let loop ([i 0] [j 0])
    (cond
      [(and (= i (string-length name)) (= j (string-length typed))) #t]
      [(or (= i (string-length name)) (= j (string-length typed))) #f]
      [(= (string-ref name i) (string-ref typed j)) (loop (+ i 1) (+ j 1))]
      [(= (string-ref typed j) (string-ref name (- i 1))) (loop i (+ j 1))]
      [else #f])))