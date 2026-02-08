(define (maxAbsValExpr arr1 arr2)
  (define n (length arr1))
  (define max-val (lambda (a b c d)
                    (apply max (map (lambda (i) 
                                      (+ (abs (- (list-ref arr1 i) a)) 
                                         (abs (- (list-ref arr2 i) b)))) 
                                    (range n)))))

  (apply max 
         (list (max-val (list-ref arr1 0) (list-ref arr2 0) 1 1)
               (max-val (list-ref arr1 0) (list-ref arr2 0) -1 -1)
               (max-val (list-ref arr1 0) (list-ref arr2 0) 1 -1)
               (max-val (list-ref arr1 0) (list-ref arr2 0) -1 1))))