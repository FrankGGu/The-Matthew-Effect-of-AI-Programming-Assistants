(define (min-swaps s)
  (define (helper s count)
    (cond [(null? s) count]
          [(char=? #\}) (helper (cdr s) (+ count 1))]
          [else (helper (cdr s) count)]))
  (let loop ([s (string->list s)] [open 0] [swap 0])
    (cond [(null? s) swap]
          [(char=? #\{) (loop (cdr s) (+ open 1) swap)]
          [else
           (if (> open 0)
               (loop (cdr s) (- open 1) swap)
               (loop (cdr s) open (+ swap 1)))])))