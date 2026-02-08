(define/contract (stone-game-iii stone-value)
  (-> (listof exact-integer?) string?)
  (let* ([n (length stone-value)]
         [dp (make-vector (+ n 1) -inf.0)]
         [suffix (make-vector (+ n 1) 0)])
    (vector-set! dp n 0)
    (for ([i (in-range (- n 1) -1 -1)])
      (vector-set! suffix i (+ (vector-ref suffix (+ i 1)) (list-ref stone-value i)))
    (for ([i (in-range (- n 1) -1 -1)])
      (for ([k (in-range 1 4)])
        (when (<= (+ i k) n)
          (vector-set! dp i (max (vector-ref dp i)
                                 (- (vector-ref suffix i)
                                    (vector-ref dp (+ i k))))))))
    (let ([diff (- (* 2 (vector-ref dp 0)) (vector-ref suffix 0))])
      (cond
        [(> diff 0) "Alice"]
        [(< diff 0) "Bob"]
        [else "Tie"]))))