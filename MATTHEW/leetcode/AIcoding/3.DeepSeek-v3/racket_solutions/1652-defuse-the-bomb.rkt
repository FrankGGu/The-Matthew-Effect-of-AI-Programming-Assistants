(define/contract (decrypt code k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([n (length code)]
         [code-vec (list->vector code)]
         [result (make-vector n 0)])
    (for ([i (in-range n)])
      (let ([sum 0])
        (if (positive? k)
            (for ([j (in-range 1 (add1 k))])
              (set! sum (+ sum (vector-ref code-vec (modulo (+ i j) n)))))
            (for ([j (in-range -1 (+ k -1) -1)])
              (set! sum (+ sum (vector-ref code-vec (modulo (+ i j) n)))))
        (vector-set! result i sum)))
    (vector->list result)))