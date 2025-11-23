(define (min-max-difference num)
  (define (change-digit n d new)
    (string->number (string-append (substring n 0 d) (number->string new) (substring n (+ d 1)))))
  (define str-num (number->string num))
  (define min-num
    (for/fold ([min str-num]) ([i (in-range (string-length str-num))])
      (if (char=? (string-ref str-num i) #\0)
          (change-digit min i 1)
          (if (char<=? (string-ref str-num i) #\9)
              (change-digit min i 0)
              min))))
  (define max-num
    (for/fold ([max str-num]) ([i (in-range (string-length str-num))])
      (if (char=? (string-ref str-num i) #\9)
          max
          (change-digit max i 9))))
  (- (string->number max-num) (string->number min-num)))

(define (maxDifference num)
  (min-max-difference num))