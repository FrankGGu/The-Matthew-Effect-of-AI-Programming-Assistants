(define/contract (get-averages nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([n (length nums)]
         [prefix (make-vector (add1 n) 0)]
         [res (make-vector n -1)])
    (for ([i (in-range n)])
      (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (list-ref nums i))))
    (for ([i (in-range n)])
      (when (and (>= i k) (< (+ i k) n))
        (vector-set! res i (quotient (- (vector-ref prefix (+ i k 1)) (vector-ref prefix (- i k))) (+ k k 1))))
    (vector->list res)))