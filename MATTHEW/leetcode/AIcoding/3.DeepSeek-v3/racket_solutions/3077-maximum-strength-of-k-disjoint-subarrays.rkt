#lang racket

(define (maximum-strength nums k)
  (let* ([n (length nums)]
         [dp (make-vector (add1 k) (make-vector (add1 n) -inf.0))]
         [max-prev (make-vector (add1 k) (make-vector (add1 n) -inf.0))])
    (for ([i (in-range (add1 n))])
      (vector-set! (vector-ref dp 0) i 0.0)
      (vector-set! (vector-ref max-prev 0) i 0.0))
    (for ([i (in-range 1 (add1 k))])
    (for* ([i (in-range 1 (add1 k))]
           [j (in-range 1 (add1 n))])
      (let ([current (vector-ref nums (sub1 j))])
        (vector-set! (vector-ref dp i) j 
                     (max (+ (vector-ref (vector-ref dp i) (sub1 j)) current)
                          (+ (vector-ref (vector-ref max-prev (sub1 i)) (sub1 j)) current)))
        (vector-set! (vector-ref max-prev i) j 
                     (max (vector-ref (vector-ref max-prev i) (sub1 j))
                          (vector-ref (vector-ref dp i) j)))))
    (let ([result (vector-ref (vector-ref max-prev k) n)])
      (if (equal? result -inf.0) 0 (exact-round result))))))