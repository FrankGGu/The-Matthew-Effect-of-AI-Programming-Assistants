(define/contract (max-coins nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [nums (append '(1) nums '(1))]
         [dp (make-vector (add1 n) (make-vector (add1 n) 0))])
    (for ([len (in-range 1 (add1 n))])
      (for ([i (in-range 0 (- (add1 n) len))])
        (let ([j (+ i len -1)])
          (for ([k (in-range i (add1 j))])
            (vector-set! (vector-ref dp i) j
              (max (vector-ref (vector-ref dp i) j)
                   (+ (vector-ref (vector-ref dp i) (- k 1))
                      (vector-ref (vector-ref dp (+ k 1)) j)
                      (* (list-ref nums i) (list-ref nums (add1 k)) (list-ref nums (+ j 2)))))))))))
    (vector-ref (vector-ref dp 0) (- n 1))))