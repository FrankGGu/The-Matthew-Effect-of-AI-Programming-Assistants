(define/contract (max-sum-of-three-subarrays nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let* ([n (length nums)]
         [prefix (make-vector (add1 n) 0)]
         [left (make-vector n 0)]
         [right (make-vector n 0)]
         [res (list -1 -1 -1)])
    (for ([i (in-range n)])
      (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (list-ref nums i))))
    (let ([total (vector-ref prefix k)])
      (vector-set! left (sub1 k) 0)
      (for ([i (in-range k n)])
        (let ([new-total (- (vector-ref prefix (add1 i)) (vector-ref prefix (add1 (- i k))))])
          (if (> new-total total)
              (begin
                (vector-set! left i i)
                (set! total new-total))
              (vector-set! left i (vector-ref left (sub1 i)))))))
    (let ([total (- (vector-ref prefix n) (vector-ref prefix (- n k)))])
      (vector-set! right (- n k) (- n k))
      (for ([i (in-range (- n k 1) -1 -1)])
        (let ([new-total (- (vector-ref prefix (+ i k)) (vector-ref prefix i))])
          (if (>= new-total total)
              (begin
                (vector-set! right i i)
                (set! total new-total))
              (vector-set! right i (vector-ref right (add1 i))))))
    (let ([max-sum 0])
      (for ([i (in-range k (- n (* 2 k)) 1)])
        (let* ([l (vector-ref left (sub1 i))]
               [r (vector-ref right (+ i k))]
               [sum1 (- (vector-ref prefix (+ l k)) (vector-ref prefix l))]
               [sum2 (- (vector-ref prefix (+ i k)) (vector-ref prefix i))]
               [sum3 (- (vector-ref prefix (+ r k)) (vector-ref prefix r))]
               [sum (+ sum1 sum2 sum3)])
          (when (> sum max-sum)
            (set! max-sum sum)
            (set! res (list l i r)))))
      res)))