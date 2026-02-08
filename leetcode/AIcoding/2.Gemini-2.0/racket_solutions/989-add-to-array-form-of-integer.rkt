(define (add-to-array-form A K)
  (let loop ([A A] [K K] [carry 0] [result '()])
    (cond
      [(and (null? A) (= K 0) (= carry 0)) (reverse result)]
      [(null? A)
       (let* ([digit (modulo (+ K carry) 10)]
              [new-carry (quotient (+ K carry) 10)])
         (loop '() new-carry new-carry (cons digit result)))]
      [else
       (let* ([digit (modulo (+ (car A) (modulo K 10) carry) 10)]
              [new-carry (quotient (+ (car A) (modulo K 10) carry) 10)])
         (loop (cdr A) (quotient K 10) new-carry (cons digit result)))])))