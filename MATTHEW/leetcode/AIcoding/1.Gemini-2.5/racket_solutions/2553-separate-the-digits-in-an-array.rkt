(define (separate-digits nums)
  (apply append
         (map (lambda (n)
                (map (lambda (c)
                       (- (char->integer c) (char->integer #\0)))
                     (string->list (number->string n))))
              nums)))