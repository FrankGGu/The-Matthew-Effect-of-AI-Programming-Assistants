(define/contract (add-to-array-form num k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([num-int (foldl (lambda (digit acc) (+ (* acc 10) digit)) 0 num)]
         [sum (+ num-int k)])
    (if (zero? sum)
        '(0)
        (let loop ([n sum] [result '()])
          (if (zero? n)
              result
              (loop (quotient n 10) (cons (remainder n 10) result))))))))