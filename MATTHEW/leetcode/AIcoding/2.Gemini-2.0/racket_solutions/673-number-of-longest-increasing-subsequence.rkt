(define (find-number-of-lis nums)
  (let* ([n (length nums)]
         [lengths (make-vector n 1)]
         [counts (make-vector n 1)])
    (for ([i (in-range 1 n)])
      (for ([j (in-range 0 i)])
        (when (< (list-ref nums j) (list-ref nums i))
          (let ([new-length (+ (vector-ref lengths j) 1)])
            (cond
              [(> new-length (vector-ref lengths i))
               (vector-set! lengths i new-length)
               (vector-set! counts i (vector-ref counts j))]
              [(= new-length (vector-ref lengths i))
               (vector-set! counts i (+ (vector-ref counts i) (vector-ref counts j)))])))))
    (let* ([max-length (apply max (vector->list lengths))]
           [result 0])
      (for ([i (in-range n)])
        (when (= (vector-ref lengths i) max-length)
          (set! result (+ result (vector-ref counts i)))))
      result)))