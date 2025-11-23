(define (longest-nice-subarray nums)
  (let loop ([left 0] [right 0] [current-or 0] [max-len 0])
    (cond
      [(>= right (length nums)) max-len]
      [else
       (let ([num (list-ref nums right)])
         (if (zero? (bitwise-and current-or num))
             (loop left (+ right 1) (bitwise-ior current-or num) (max max-len (- right left 0)))
             (loop (+ left 1) right (bitwise-xor current-or (list-ref nums left)) max-len)))))))