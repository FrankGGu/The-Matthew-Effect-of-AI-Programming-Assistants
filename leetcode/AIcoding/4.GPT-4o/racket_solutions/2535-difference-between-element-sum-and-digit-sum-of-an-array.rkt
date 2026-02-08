(define (differenceBetweenElementSumAndDigitSum nums)
  (define element-sum (apply + nums))
  (define digit-sum (apply + (map (lambda (x) (apply + (map (lambda (d) (string->number (string (char->integer d)))) (string->list (number->string x))))) nums)))
  (- element-sum digit-sum))