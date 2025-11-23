(define (min-swaps s)
  (let loop ([i 0] [j (- (string-length s) 1)] [open 0] [close 0] [swaps 0])
    (cond
      [(>= i j) swaps]
      [(char=? (string-ref s i) #\[)
       (loop (+ i 1) j (+ open 1) close swaps)]
      [else
       (loop (+ i 1) j open (+ close 1) swaps)]
      [(> close open)
       (loop i (- j 1) open (- close 1) (+ swaps 1))]
      [else
       (loop i j open close swaps)])))