(define (checkZeroOnes s)
  (define (count-segments char)
    (define segments (filter (lambda (x) (equal? (car x) char)) (map length (string-split s #\0))))
    (if (null? segments) 0 (apply max segments)))
  (> (count-segments #\1) (count-segments #\0)))

(checkZeroOnes "110001111") ; Example input