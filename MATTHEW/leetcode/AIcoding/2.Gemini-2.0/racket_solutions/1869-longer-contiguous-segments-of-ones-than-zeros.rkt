(define (check-zero-ones s)
  (let loop ([s (string->list s)] [ones 0] [zeros 0] [curr-ones 0] [curr-zeros 0])
    (cond
      [(empty? s) (cons ones zeros)]
      [(= (car s) #\1)
       (loop (cdr s) (max ones (+ 1 curr-ones)) zeros (+ 1 curr-ones) 0)]
      [else
       (loop (cdr s) ones (max zeros (+ 1 curr-zeros)) 0 (+ 1 curr-zeros))])))

(define (longer-contiguous-segments s)
  (let ([result (check-zero-ones s)])
    (> (car result) (cdr result))))