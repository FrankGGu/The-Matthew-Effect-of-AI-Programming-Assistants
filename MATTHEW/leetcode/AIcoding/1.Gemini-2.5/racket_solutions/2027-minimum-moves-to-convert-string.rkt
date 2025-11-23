(define (minimum-moves s)
  (let* ((n (string-length s)))
    (let loop ((i 0) (moves 0))
      (cond
        ((>= i n) moves)
        ((char=? (string-ref s i) #\X)
         (loop (+ i 3) (+ moves 1)))
        (else
         (loop (+ i 1) moves))))))