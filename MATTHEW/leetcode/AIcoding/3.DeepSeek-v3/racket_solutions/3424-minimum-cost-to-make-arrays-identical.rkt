(define/contract (min-cost nums cost target)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([nums-cost (sort (map cons nums cost) (lambda (a b) (< (car a) (car b))))]
         [nums (map car nums-cost)]
         [cost (map cdr nums-cost)]
         [n (length nums)]
         [prefix (make-vector (add1 n) 0)]
         [prefix-cost (make-vector (add1 n) 0)]
         [total-cost 0])
    (for ([i (in-range n)])
      (vector-set! prefix-cost (add1 i) (+ (vector-ref prefix-cost i) (list-ref cost i)))
      (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (* (list-ref nums i) (list-ref cost i))))
    (set! total-cost (vector-ref prefix-cost n))
    (let loop ([left 0] [res +inf.0])
      (if (>= left n)
          res
          (let* ([right left]
                  [current (list-ref nums left)]
                  [sum-left (* current (vector-ref prefix-cost (add1 left)))]
                  [sum-right (* current (- total-cost (vector-ref prefix-cost (add1 left))))]
                  [total (+ (- sum-left (vector-ref prefix (add1 left)))
                            (- (- (vector-ref prefix n) (vector-ref prefix (add1 left))) sum-right))])
            (loop (add1 left) (min res total)))))))