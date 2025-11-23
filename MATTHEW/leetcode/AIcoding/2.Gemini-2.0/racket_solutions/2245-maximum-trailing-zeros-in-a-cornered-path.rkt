(define (max-trailing-zeros grid)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [row-prefix-2 (make-vector m (make-vector (add1 n) 0))]
         [row-prefix-5 (make-vector m (make-vector (add1 n) 0))]
         [col-prefix-2 (make-vector n (make-vector (add1 m) 0))]
         [col-prefix-5 (make-vector n (make-vector (add1 m) 0))])

    (define (count-factors num factor)
      (let loop ([n num] [count 0])
        (if (zero? n)
            count
            (if (zero? (modulo n factor))
                (loop (quotient n factor) (add1 count))
                count))))

    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (vector-set! (vector-ref row-prefix-2 i) (add1 j) (+ (vector-ref (vector-ref row-prefix-2 i) j) (count-factors (list-ref (list-ref grid i) j) 2)))
        (vector-set! (vector-ref row-prefix-5 i) (add1 j) (+ (vector-ref (vector-ref row-prefix-5 i) j) (count-factors (list-ref (list-ref grid i) j) 5))))

    (for ([j (in-range n)])
      (for ([i (in-range m)])
        (vector-set! (vector-ref col-prefix-2 j) (add1 i) (+ (vector-ref (vector-ref col-prefix-2 j) i) (count-factors (list-ref (list-ref grid i) j) 2)))
        (vector-set! (vector-ref col-prefix-5 j) (add1 i) (+ (vector-ref (vector-ref col-prefix-5 j) i) (count-factors (list-ref (list-ref grid i) j) 5))))

    (let ([max-zeros 0])
      (for ([i (in-range m)])
        (for ([j (in-range n)])
          (let* ([val (list-ref (list-ref grid i) j)]
                 [zeros1 (min (+ (- (vector-ref (vector-ref row-prefix-2 i) n) (vector-ref (vector-ref row-prefix-2 i) j)) (vector-ref (vector-ref col-prefix-2 j) i) (count-factors val 2))
                             (+ (- (vector-ref (vector-ref row-prefix-5 i) n) (vector-ref (vector-ref row-prefix-5 i) j)) (vector-ref (vector-ref col-prefix-5 j) i) (count-factors val 5)))
                 [zeros2 (min (+ (vector-ref (vector-ref row-prefix-2 i) j) (- (vector-ref (vector-ref col-prefix-2 j) m) (vector-ref (vector-ref col-prefix-2 j) (add1 i))) (count-factors val 2))
                             (+ (vector-ref (vector-ref row-prefix-5 i) j) (- (vector-ref (vector-ref col-prefix-5 j) m) (vector-ref (vector-ref col-prefix-5 j) (add1 i))) (count-factors val 5)))
                 [zeros3 (min (+ (- (vector-ref (vector-ref row-prefix-2 i) n) (vector-ref (vector-ref row-prefix-2 i) j)) (- (vector-ref (vector-ref col-prefix-2 j) m) (vector-ref (vector-ref col-prefix-2 j) (add1 i))) (count-factors val 2))
                             (+ (- (vector-ref (vector-ref row-prefix-5 i) n) (vector-ref (vector-ref row-prefix-5 i) j)) (- (vector-ref (vector-ref col-prefix-5 j) m) (vector-ref (vector-ref col-prefix-5 j) (add1 i))) (count-factors val 5)))
                 [zeros4 (min (+ (vector-ref (vector-ref row-prefix-2 i) j) (vector-ref (vector-ref col-prefix-2 j) i) (count-factors val 2))
                             (+ (vector-ref (vector-ref row-prefix-5 i) j) (vector-ref (vector-ref col-prefix-5 j) i) (count-factors val 5)))])
            (set! max-zeros (max max-zeros zeros1 zeros2 zeros3 zeros4)))))
      max-zeros)))