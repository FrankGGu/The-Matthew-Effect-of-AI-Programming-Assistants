(define (longest-alphabetical-continuous-substring s)
  (let loop ([s (string->list s)]
             [max-len 0]
             [curr-len 0]
             [prev #f])
    (cond
      [(empty? s)
       (max max-len curr-len)]
      [else
       (let ([curr (car s)])
         (cond
           [(and prev (= (char->integer curr) (+ (char->integer prev) 1)))
            (loop (cdr s) max-len (+ curr-len 1) curr)]
           [else
            (loop (cdr s) (max max-len curr-len) 1 curr)]))])))