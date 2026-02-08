(define (minOperations nums k)
  (define (countOps x)
    (if (null? x) 0
        (+ (if (= (car x) k) 0 1) (countOps (cdr x)))))
  (countOps nums))

(minOperations '(1 2 3 4 5) 3)