(define (minimum-steps s)
  (let loop ([i 0] [j 0] [steps 0])
    (cond
      [(>= i (string-length s)) steps]
      [(char=? (string-ref s i) #\1) (loop (add1 i) j steps)]
      [else (loop (add1 i) (add1 j) (+ steps (- i j)))])))