(define (minOperations nums)
  (define (count-remainders lst)
    (foldl (lambda (x acc)
             (cond
               [(= (modulo x 3) 0) (list-ref acc 0)]
               [(= (modulo x 3) 1) (list (+ 1 (list-ref acc 1)) (list-ref acc 2))]
               [(= (modulo x 3) 2) (list (list-ref acc 0) (+ 1 (list-ref acc 1)))]))
           (list 0 0 0)
           lst))
  (define remainders (count-remainders nums))
  (define count1 (list-ref remainders 1))
  (define count2 (list-ref remainders 2))
  (+ count1 (quotient count2 2) (modulo count2 2)))