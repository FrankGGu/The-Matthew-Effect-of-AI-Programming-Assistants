(define/contract (get-no-zero-integers n)
  (-> exact-integer? (listof exact-integer?))
  (define (no-zero? num)
    (let loop ([n num])
      (cond
        [(zero? n) #t]
        [(zero? (remainder n 10)) #f]
        [else (loop (quotient n 10))])))
  (let loop ([a 1])
    (let ([b (- n a)])
      (if (and (no-zero? a) (no-zero? b))
          (list a b)
          (loop (add1 a))))))