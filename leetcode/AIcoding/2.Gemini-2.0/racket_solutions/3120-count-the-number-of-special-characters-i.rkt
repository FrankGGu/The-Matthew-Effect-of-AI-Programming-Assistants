(define (count-special-characters s)
  (let loop ([str (string->list s)]
             [count 0])
    (cond
      [(empty? str) count]
      [else (let ([c (car str)])
              (if (or (char-alphabetic? c) (char-numeric? c) (char=? c #\ ))
                  (loop (cdr str) count)
                  (loop (cdr str) (+ count 1))))])))