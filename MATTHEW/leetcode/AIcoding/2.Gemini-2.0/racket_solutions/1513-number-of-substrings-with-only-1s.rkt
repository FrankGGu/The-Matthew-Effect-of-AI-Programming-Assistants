(define (num-sub (s))
  (let loop ([s s] [count 0] [current 0])
    (cond
      [(string=? s "") count]
      [(string=? (substring s 0 1) "1")
       (loop (substring s 1) (+ count (+ current 1)) (+ current 1))]
      [else (loop (substring s 1) count 0)])))