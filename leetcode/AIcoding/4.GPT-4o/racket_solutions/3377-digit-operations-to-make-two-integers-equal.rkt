(define (minOperations A B)
  (define (digits n)
    (if (= n 0)
        '()
        (cons (modulo n 10) (digits (quotient n 10)))))
  (define (count-digits lst)
    (foldl (lambda (x acc) (vector-set! acc x (+ 1 (vector-ref acc x)))) (make-vector 10 0) lst))

  (define a-digits (count-digits (digits A)))
  (define b-digits (count-digits (digits B)))

  (define (digit-operation-count a b)
    (foldl (lambda (i acc) (+ acc (abs (- (vector-ref a i) (vector-ref b i))))) 0 (range 10)))

  (digit-operation-count a-digits b-digits))

(define (main)
  (display (minOperations 123 321)))

(main)