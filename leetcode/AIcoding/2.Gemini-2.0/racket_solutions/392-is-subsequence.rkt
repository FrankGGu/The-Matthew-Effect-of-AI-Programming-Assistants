(define (is-subsequence s t)
  (let loop ([s-idx 0] [t-idx 0])
    (cond
      [(>= s-idx (string-length s)) #t]
      [(>= t-idx (string-length t)) #f]
      [(= (string-ref s s-idx) (string-ref t t-idx)) (loop (+ s-idx 1) (+ t-idx 1))]
      [else (loop s-idx (+ t-idx 1))])))