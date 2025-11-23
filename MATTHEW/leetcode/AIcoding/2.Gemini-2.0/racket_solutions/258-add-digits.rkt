(define (add-digits num)
  (if (zero? num)
      0
      (if (zero? (modulo num 9))
          9
          (modulo num 9))))