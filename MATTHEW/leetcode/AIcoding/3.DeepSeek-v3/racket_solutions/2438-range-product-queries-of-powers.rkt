(define/contract (product-queries n queries)
  (-> exact-integer? (listof (listof exact-integer?)) (listof exact-integer?))
  (define powers
    (let loop ([n n] [i 0] [acc '()])
      (if (zero? n)
          acc
          (loop (arithmetic-shift n -1) (add1 i) (if (odd? n) (cons i acc) acc)))))
  (define prefix (list->vector (foldl (lambda (x acc) (cons (* (if (null? acc) 1 (car acc)) (expt 2 x)) acc)) '() powers)))
  (define (query l r)
    (let ([r-val (if (< r (vector-length prefix)) (vector-ref prefix r) 1)]
          [l-val (if (< (sub1 l) (vector-length prefix)) (vector-ref prefix (sub1 l)) 1)])
      (quotient r-val l-val)))
  (map (lambda (q) (modulo (query (first q) (second q)) 1000000007)) queries)