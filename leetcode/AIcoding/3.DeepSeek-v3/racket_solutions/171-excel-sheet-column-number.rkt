(define (title-to-number columnTitle)
  (let loop ([s columnTitle] [result 0])
    (if (null? s)
        result
        (loop (cdr s) (+ (* result 26) (- (char->integer (car s)) 64)))))