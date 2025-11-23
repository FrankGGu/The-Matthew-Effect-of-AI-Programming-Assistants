(define (canBeValid s locked)
  (let loop ([i 0] [balance 0] [flex 0])
    (cond
      [(= i (string-length s))
       (zero? balance)]
      [(char=? (string-ref locked i) #\1)
       (if (char=? (string-ref s i) #\()
           (loop (+ i 1) (+ balance 1) flex)
           (and (>= balance 1) (loop (+ i 1) (- balance 1) flex))]
      [else
       (or (loop (+ i 1) (+ balance 1) (+ flex 1))
           (and (>= balance 1) (loop (+ i 1) (- balance 1) (+ flex 1))))])))