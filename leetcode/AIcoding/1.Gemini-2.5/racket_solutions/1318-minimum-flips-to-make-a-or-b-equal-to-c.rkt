(define (min-flips a b c)
  (let loop ((current-a a)
             (current-b b)
             (current-c c)
             (flips 0))
    (if (and (zero? current-a)
             (zero? current-b)
             (zero? current-c))
        flips
        (let* ((bit-a (bitwise-and current-a 1))
               (bit-b (bitwise-and current-b 1))
               (bit-c (bitwise-and current-c 1)))
          (loop (arithmetic-shift current-a -1)
                (arithmetic-shift current-b -1)
                (arithmetic-shift current-c -1)
                (+ flips
                   (cond
                     ((zero? bit-c) ; Target bit is 0
                      (+ (if (zero? bit-a) 0 1)
                         (if (zero? bit-b) 0 1)))
                     (else ; Target bit is 1
                      (if (and (zero? bit-a) (zero? bit-b)) 1 0)))))))))