(define/contract (maximum-sum arr)
  (-> (listof exact-integer?) exact-integer?)
  (define n (length arr))
  (if (= n 1) (car arr)
      (let ([left (make-vector n 0)]
            [right (make-vector n 0)]
            [max-sum (car arr)]
            [current-sum (car arr)])
        (vector-set! left 0 (car arr))
        (for ([i (in-range 1 n)])
          (set! current-sum (max (list-ref arr i) (+ current-sum (list-ref arr i)))
          (vector-set! left i current-sum)
          (set! max-sum (max max-sum current-sum)))
        (vector-set! right (- n 1) (list-ref arr (- n 1)))
        (for ([i (in-range (- n 2) -1 -1)])
          (vector-set! right i (max (list-ref arr i) (+ (vector-ref right (+ i 1)) (list-ref arr i))))
        (for ([i (in-range 1 (- n 1))])
          (set! max-sum (max max-sum (+ (vector-ref left (- i 1)) (vector-ref right (+ i 1)))))
        max-sum)))