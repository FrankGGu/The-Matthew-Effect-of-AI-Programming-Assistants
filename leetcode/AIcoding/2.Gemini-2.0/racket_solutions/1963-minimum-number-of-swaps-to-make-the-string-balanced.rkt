(define (min-swaps-balanced s)
  (let loop ([chars (string->list s)] [open 0] [swaps 0])
    (cond
      [(null? chars) swaps]
      [(char=? (car chars) #\[)
       (loop (cdr chars) (+ open 1) swaps)]
      [else
       (if (> open 0)
           (loop (cdr chars) (- open 1) swaps)
           (loop (cdr chars) open (+ swaps 1)))])))