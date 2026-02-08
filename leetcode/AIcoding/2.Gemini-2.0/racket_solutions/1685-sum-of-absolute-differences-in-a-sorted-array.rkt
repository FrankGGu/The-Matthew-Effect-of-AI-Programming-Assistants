(define (sum-absolute-differences xs)
  (let* ([n (length xs)]
         [prefix-sums (make-vector (add1 n) 0)]
         [_ (for/fold (void) ([i (in-range 0 n)])
              (vector-set! prefix-sums (add1 i) (+ (vector-ref prefix-sums i) (list-ref xs i))))]
         [result (make-vector n 0)])
    (for ([i (in-range 0 n)])
      (let* ([x (list-ref xs i)]
             [left-sum (vector-ref prefix-sums i)]
             [right-sum (- (vector-ref prefix-sums n) (vector-ref prefix-sums (add1 i)))]
             [left-count i]
             [right-count (- n (add1 i))]
             [left-diff (- (* x left-count) left-sum)]
             [right-diff (- right-sum (* x right-count))])
        (vector-set! result i (+ left-diff right-diff))))
    (vector->list result)))