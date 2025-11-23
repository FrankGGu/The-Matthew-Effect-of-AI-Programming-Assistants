(define (minFlips s)
  (let loop ([i 1] [flips 0])
    (cond
      [(>= i (string-length s)) flips]
      [(= (string-ref s (- i 1)) (string-ref s i)) (loop (+ i 1) flips)]
      [else (loop (+ i 1) (+ flips 1))])))