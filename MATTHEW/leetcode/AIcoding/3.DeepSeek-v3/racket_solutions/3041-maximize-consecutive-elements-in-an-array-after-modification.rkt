(define/contract (maximize-consecutive-elements nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [nums (sort nums <)]
         [dp (make-hash)]
         [max-len 0])
    (for ([i (in-range n)])
      (let ([current (list-ref nums i)])
      (hash-set! dp current (max (hash-ref dp (- current 1) 0) (hash-ref dp (- current 2) 0)))))
    (for ([(k v) (in-hash dp)])
      (set! max-len (max max-len v)))
    max-len))