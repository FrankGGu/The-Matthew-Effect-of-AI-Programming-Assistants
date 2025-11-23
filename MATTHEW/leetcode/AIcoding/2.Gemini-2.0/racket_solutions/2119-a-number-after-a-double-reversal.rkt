(define (is-same-after-reverse num)
  (cond
    [(zero? num) #t]
    [(zero? (modulo num 10)) #f]
    [else #t]))