(define (addNegabinary arr1 arr2)
  (define (add a b carry)
    (cond
      [(and (null? a) (null? b) (= carry 0)) '()]
      [(null? a) (add '() b carry)]
      [(null? b) (add a '() carry)]
      [else
       (let* ((sum (+ (car a) (car b) carry))
              (next-carry (if (= sum 2) -1 (if (>= sum 3) -1 0)))
              (next-digit (if (= sum 2) 0 (if (= sum 3) 1 sum))))
         (cons next-digit (add (cdr a) (cdr b) next-carry)))]))
  (reverse (add (reverse arr1) (reverse arr2) 0)))

(addNegabinary '(1 0 1) '(1 0 1))