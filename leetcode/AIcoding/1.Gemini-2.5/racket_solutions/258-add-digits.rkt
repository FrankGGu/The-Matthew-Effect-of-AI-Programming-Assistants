(define (add-digits num)
  (if (= num 0)
      0
      (if (= (remainder num 9) 0)
          9
          (remainder num 9))))