(define/contract (lemonade-change bills)
  (-> (listof exact-integer?) boolean?)
  (let loop ([bills bills] [five 0] [ten 0])
    (cond
      [(null? bills) #t]
      [(= (car bills) 5) (loop (cdr bills) (add1 five) ten)]
      [(= (car bills) 10)
       (if (> five 0)
           (loop (cdr bills) (sub1 five) (add1 ten))
           #f)]
      [else
       (if (and (> ten 0) (> five 0))
           (loop (cdr bills) (sub1 five) (sub1 ten))
           (if (>= five 3)
               (loop (cdr bills) (- five 3) ten)
               #f))])))