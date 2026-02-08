(define/contract (maximum-score nums multipliers)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [m (length multipliers)]
         [dp (make-vector (add1 m) (make-vector (add1 m) 0))])
    (for ([k (in-range (sub1 m) -1 -1)])
      (for ([left (in-range k -1 -1)])
        (let ([right (- (sub1 n) (- k left))])
          (if (= k (sub1 m))
              (vector-set! (vector-ref dp left) k 
                           (max (* (list-ref nums left) (list-ref multipliers k))
                                (* (list-ref nums right) (list-ref multipliers k))))
              (vector-set! (vector-ref dp left) k 
                           (max (+ (* (list-ref nums left) (list-ref multipliers k)) 
                                     (vector-ref (vector-ref dp (add1 left)) (add1 k)))
                                (+ (* (list-ref nums right) (list-ref multipliers k)) 
                                     (vector-ref (vector-ref dp left) (add1 k))))))))
    (vector-ref (vector-ref dp 0) 0)))