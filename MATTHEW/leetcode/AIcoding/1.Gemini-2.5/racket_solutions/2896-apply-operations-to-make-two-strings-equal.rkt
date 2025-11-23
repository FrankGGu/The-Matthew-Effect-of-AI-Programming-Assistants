(define (min-cost-to-make-two-strings-equal s1 s2 x)
  (let* ([n (string-length s1)]
         [diff-indices (for/list ([i (in-range n)]
                                  #:when (char-not-equal? (string-ref s1 i) (string-ref s2 i)))
                         i)]
         [k (length diff-indices)])

    (cond
      [(odd? k) -1]
      [(zero? k) 0]
      [else
       (define dp (make-vector (+ k 1) 0))

       (vector-set! dp 0 0)
       (vector-set! dp 1 1)

       (for ([i (in-range 2 (+ k 1))])
         (let ([cost-op1 (+ (vector-ref dp (- i 1)) 1)]
               [cost-op2 (+ (vector-ref dp (- i 2)) x)])
           (vector-set! dp i (min cost-op1 cost-op2))))

       (vector-ref dp k)])))