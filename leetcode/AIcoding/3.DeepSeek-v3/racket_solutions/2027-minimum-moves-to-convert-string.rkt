(define (minimum-moves s)
  (let loop ([i 0] [count 0])
    (cond
      [(>= i (string-length s)) count]
      [(char=? (string-ref s i) #\X)
       (loop (+ i 3) (+ count 1))]
      [else (loop (+ i 1) count)])))