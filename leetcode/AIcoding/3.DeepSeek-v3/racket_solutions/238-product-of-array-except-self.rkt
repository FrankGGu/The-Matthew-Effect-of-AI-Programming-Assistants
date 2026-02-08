(define/contract (product-except-self nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums)]
         [left (make-vector n 1)]
         [right (make-vector n 1)]
         [result (make-list n 1)])
    (for ([i (in-range 1 n)])
      (vector-set! left i (* (vector-ref left (- i 1)) (list-ref nums (- i 1)))))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! right i (* (vector-ref right (+ i 1)) (list-ref nums (+ i 1)))))
    (for ([i (in-range n)])
      (list-set! result i (* (vector-ref left i) (vector-ref right i))))
    result))