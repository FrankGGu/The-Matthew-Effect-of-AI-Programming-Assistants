(define (min-add-to-make-valid s)
  (let loop ([s (string->list s)] [open-count 0] [close-count 0])
    (cond
      [(null? s) (+ open-count close-count)]
      [(char=? (car s) #\() (loop (cdr s) (add1 open-count) close-count)]
      [else
       (if (> open-count 0)
           (loop (cdr s) (sub1 open-count) close-count)
           (loop (cdr s) open-count (add1 close-count)))])))