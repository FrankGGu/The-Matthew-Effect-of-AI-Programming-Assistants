(define/contract (minimum-subarray-sums nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (letrec ([n (length nums)]
           [dp (make-vector n 0)]
           [prefix (make-vector n 0)])
    (vector-set! prefix 0 (car nums))
    (for ([i (in-range 1 n)])
      (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref nums i))))
    (vector-set! dp 0 0)
    (for ([i (in-range 1 n)])
      (vector-set! dp i (min (vector-ref dp (- i 1)) (vector-ref prefix (- i 1)))))
    (for ([i (in-range 1 n)])
      (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp (- i 1)) (vector-ref prefix (- i 1))))))
    (vector->list dp)))