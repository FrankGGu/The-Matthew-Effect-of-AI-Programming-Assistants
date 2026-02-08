(define/contract (find-number-of-lis nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [dp (make-vector n 1)]
         [count (make-vector n 1)]
         [max-len 1])
    (for ([i (in-range n)])
      (for ([j (in-range i)])
        (when (> (list-ref nums i) (list-ref nums j))
          (cond [(> (add1 (vector-ref dp j)) (vector-ref dp i))
                 (vector-set! dp i (add1 (vector-ref dp j)))
                 (vector-set! count i (vector-ref count j))]
                [(= (add1 (vector-ref dp j)) (vector-ref dp i))
                 (vector-set! count i (+ (vector-ref count i) (vector-ref count j)))]))))
      (set! max-len (max max-len (vector-ref dp i))))
    (let ([res 0])
      (for ([i (in-range n)])
        (when (= (vector-ref dp i) max-len)
          (set! res (+ res (vector-ref count i)))))
      res)))