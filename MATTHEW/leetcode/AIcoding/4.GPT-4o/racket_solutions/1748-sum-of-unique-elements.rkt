(define (sumOfUnique nums)
  (define freq (make-hash))
  (for-each (lambda (num) 
              (hash-set! freq num (add1 (hash-ref freq num 0)))) nums)
  (foldl (lambda (num acc)
            (if (= (hash-ref freq num) 1) 
                (+ acc num) 
                acc)) 
          0 
          nums))

(sumOfUnique '(1 2 3 2)) ; Example usage