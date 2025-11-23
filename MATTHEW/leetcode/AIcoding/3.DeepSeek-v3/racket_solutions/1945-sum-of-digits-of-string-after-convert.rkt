(define (getLucky s k)
  (define (char->num c)
    (- (char->integer c) 96))

  (define (sum-digits n)
    (let loop ([n n] [sum 0])
      (if (zero? n)
          sum
          (loop (quotient n 10) (+ sum (remainder n 10))))))

  (let loop ([s s] [k k] [num 0])
    (cond
      [(> k 0)
       (let* ([new-num (if (zero? num)
                           (apply + (map char->num (string->list s)))
                           (sum-digits num))])
         (loop s (- k 1) new-num))]
      [else num])))