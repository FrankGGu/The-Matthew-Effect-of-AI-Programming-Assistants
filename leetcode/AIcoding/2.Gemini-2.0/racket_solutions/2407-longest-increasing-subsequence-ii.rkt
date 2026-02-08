(define (length-of-lis nums k)
  (let* ([n (length nums)]
         [dp (make-vector n 1)])
    (for ([i (in-range 1 n)])
      (for ([j (in-range 0 i)])
        (when (and (<= (vector-ref nums j) (vector-ref nums i))
                   (<= (- (vector-ref nums i) (vector-ref nums j)) k))
          (vector-set! dp i (max (vector-ref dp i) (+ 1 (vector-ref dp j)))))))
    (apply max (vector->list dp))))