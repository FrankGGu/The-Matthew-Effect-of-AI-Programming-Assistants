(define (longest-well-performing-interval hours)
  (let* ([n (length hours)]
         [balance (make-vector (add1 n) 0)]
         [prefixes (for/list ([i (in-range n)])
                     (if (> (list-ref hours i) 8) 1 -1))]
         [prefix-sums (for/list ([i (in-range n)])
                        (if (zero? i) (list-ref prefixes i) (+ (list-ref prefixes i) (vector-ref balance i))))]
         [ans 0])
    (vector-set! balance 0 0)
    (for/list ([i (in-range n)])
      (vector-set! balance (add1 i) (+ (vector-ref balance i) (list-ref prefixes i))))
    (let loop ([i 0] [max-len 0])
      (if (= i n)
          max-len
          (let* ([j (add1 i)]
                 [curr-max-len max-len])
            (let inner-loop ([k j])
              (cond
                [(> k n) curr-max-len]
                [(> (vector-ref balance k) (vector-ref balance i))
                 (let ([len (- k i)])
                   (inner-loop k))]
                [else (inner-loop (add1 k))])))))))