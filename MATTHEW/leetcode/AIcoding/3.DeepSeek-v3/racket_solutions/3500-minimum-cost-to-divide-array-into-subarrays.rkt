(define/contract (minimum-cost nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [dp (make-vector (add1 n) +inf.0)]
         [cost (lambda (i j) (apply max (take (drop nums i) (- j i))))])
    (vector-set! dp 0 0)
    (for ([j (in-range 1 (add1 n))])
      (for ([i (in-range (max 0 (- j k)) j)])
        (vector-set! dp j (min (vector-ref dp j)
                               (+ (vector-ref dp i) (cost i j)))))
    (vector-ref dp n)))