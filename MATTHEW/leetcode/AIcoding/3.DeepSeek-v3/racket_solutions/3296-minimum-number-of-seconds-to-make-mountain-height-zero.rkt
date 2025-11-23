(define/contract (minimum-time nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [left (make-vector n 0)]
         [right (make-vector n 0)]
         [result 0])
    (for ([i (in-range 1 n)])
      (vector-set! left i (max (vector-ref left (- i 1)) (list-ref nums (- i 1))))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! right i (max (vector-ref right (+ i 1)) (list-ref nums (+ i 1))))
    (for ([i (in-range n)])
      (set! result (+ result (max 0 (- (list-ref nums i) (min (vector-ref left i) (vector-ref right i))))))
    result))