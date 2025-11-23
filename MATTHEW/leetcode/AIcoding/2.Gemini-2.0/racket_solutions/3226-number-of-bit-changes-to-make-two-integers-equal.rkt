(define (min-bit-flips start goal)
  (let loop ([n (bitwise-xor start goal)]
             [count 0])
    (if (= n 0)
        count
        (loop (bitwise-and n (- n 1)) (+ count 1)))))