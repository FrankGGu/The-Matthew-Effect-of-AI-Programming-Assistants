(define (lemonadeChange bills)
  (define (helper bills five ten)
    (cond
      [(null? bills) #t]
      [(= (car bills) 5) (helper (cdr bills) (+ five 1) ten)]
      [(= (car bills) 10) (if (> five 0)
                             (helper (cdr bills) (- five 1) (+ ten 1))
                             #f)]
      [(= (car bills) 20) (cond
                           [(> ten 0) (if (> five 0)
                                          (helper (cdr bills) (- five 1) (- ten 1))
                                          #f)]
                           [(> five 2) (helper (cdr bills) (- five 3) ten)]
                           [#f])]))
  (helper bills 0 0))

(lemonadeChange '(5 5 5 10 20)) ; should return #t