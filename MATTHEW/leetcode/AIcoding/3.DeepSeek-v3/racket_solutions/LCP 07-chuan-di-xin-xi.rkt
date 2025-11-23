(define (num-ways n relation k)
  (let* ([graph (make-hash)]
         [dp (make-hash)])
    (for ([r relation])
      (let ([u (first r)]
            [v (second r)])
        (hash-update! graph u (lambda (lst) (cons v lst)) '())))
    (hash-set! dp 0 (make-vector n 0))
    (vector-set! (hash-ref dp 0) 0 1)
    (for ([i (in-range 1 (+ k 1))])
      (hash-set! dp i (make-vector n 0))
      (for ([u (in-range n)])
        (for ([v (hash-ref graph u '())])
          (vector-set! (hash-ref dp i) v 
                       (+ (vector-ref (hash-ref dp i) v) 
                          (vector-ref (hash-ref dp (- i 1)) u))))))
    (vector-ref (hash-ref dp k) (- n 1))))