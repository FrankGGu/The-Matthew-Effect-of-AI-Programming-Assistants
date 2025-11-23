(define (min-flips target)
  (let loop ([i 0] [current '0] [flips 0])
    (if (>= i (string-length target))
        flips
        (let ([target-char (string-ref target i)])
          (if (eqv? target-char current)
              (loop (add1 i) current flips)
              (loop (add1 i) target-char (add1 flips))))))