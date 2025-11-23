(define (count-binary-substrings s)
  (let loop ([s (string->list s)]
             [prev-len 0]
             [curr-len 1]
             [count 0])
    (cond
      [(null? (cdr s))
       count]
      [(= (car s) (cadr s))
       (loop (cdr s) prev-len (+ curr-len 1) count)]
      [else
       (loop (cdr s) curr-len 1 (+ count (min prev-len curr-len)))])))