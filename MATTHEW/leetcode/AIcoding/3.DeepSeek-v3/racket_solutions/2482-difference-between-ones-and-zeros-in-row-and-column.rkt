(define/contract (ones-minus-zeros grid)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let* ([m (length grid)]
         [n (if (zero? m) 0 (length (car grid)))]
         [row-ones (make-vector m 0)]
         [col-ones (make-vector n 0)])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (when (= (list-ref (list-ref grid i) j) 1)
          (vector-set! row-ones i (add1 (vector-ref row-ones i)))
          (vector-set! col-ones j (add1 (vector-ref col-ones j))))
    (for/list ([i (in-range m)])
      (for/list ([j (in-range n)])
        (- (+ (vector-ref row-ones i) (vector-ref col-ones j))
           (- (- m (vector-ref row-ones i)) (- n (vector-ref col-ones j)))))))