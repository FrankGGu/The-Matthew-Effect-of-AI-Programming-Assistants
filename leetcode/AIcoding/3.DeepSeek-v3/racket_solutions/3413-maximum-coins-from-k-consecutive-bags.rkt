(define/contract (max-coins nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [nums (list->vector (sort nums <))]
         [prefix (make-vector (+ n 1) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix (+ i 1) (+ (vector-ref prefix i) (vector-ref nums i))))
    (let loop ([i 0] [j (- k 1)] [res 0])
      (if (> j n)
          res
          (let* ([sum (if (>= j 0) (- (vector-ref prefix (+ j 1)) (vector-ref prefix i)) 0)]
                 [new-res (max res sum)])
            (loop (+ i 1) (+ j 1) new-res)))))))