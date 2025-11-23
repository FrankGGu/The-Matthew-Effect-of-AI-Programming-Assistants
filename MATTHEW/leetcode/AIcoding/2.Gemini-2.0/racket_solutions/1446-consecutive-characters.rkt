(define (max-power s)
  (let loop ([str (string->list s)] [curr-char #f] [curr-len 0] [max-len 0])
    (cond
      [(empty? str) (max max-len curr-len)]
      [else
       (let ([c (car str)])
         (if (equal? c curr-char)
             (loop (cdr str) c (+ 1 curr-len) max-len)
             (loop (cdr str) c 1 (max max-len curr-len)))))])))