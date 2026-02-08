(define (append-characters s t)
  (let loop ([s-idx 0] [t-idx 0])
    (cond
      [(= t-idx (string-length t)) 0]
      [(= s-idx (string-length s)) (- (string-length t) t-idx)]
      [(char=? (string-ref s s-idx) (string-ref t t-idx))
       (loop (+ s-idx 1) (+ t-idx 1))]
      [else (loop (+ s-idx 1) t-idx)])))