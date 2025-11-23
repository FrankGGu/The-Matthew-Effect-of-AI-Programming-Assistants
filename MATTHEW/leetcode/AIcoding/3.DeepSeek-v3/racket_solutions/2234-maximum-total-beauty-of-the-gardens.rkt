(define/contract (maximum-beauty flowers target full partial)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([flowers (sort flowers <)]
         [n (length flowers)]
         [prefix (make-vector (add1 n) 0)])
    (for ([i (in-range 1 (add1 n))])
      (vector-set! prefix i (+ (vector-ref prefix (sub1 i)) (list-ref flowers (sub1 i)))))
    (let loop ([i 0]
               [j (sub1 n)]
               [res 0])
      (cond
        [(> i j) res]
        [else
         (let* ([m (quotient (+ i j) 2)]
                [sum (vector-ref prefix (add1 m))]
                [avg (quotient sum (add1 m))])
           (if (< avg partial)
               (loop (add1 m) j res)
               (loop i (sub1 m) res)))]))))