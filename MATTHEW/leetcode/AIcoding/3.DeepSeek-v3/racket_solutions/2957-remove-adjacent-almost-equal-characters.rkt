(define (remove-adjacent-almost-equal-characters s)
  (let loop ([s (string->list s)]
             [count 0]
             [prev #\0])
    (cond
      [(null? s) count]
      [(or (char=? (car s) prev)
           (char=? (car s) (integer->char (+ (char->integer prev) 1)))
       (loop (cdr s) (add1 count) (integer->char (+ (char->integer (car s)) 1)))]
      [else (loop (cdr s) count (car s))])))