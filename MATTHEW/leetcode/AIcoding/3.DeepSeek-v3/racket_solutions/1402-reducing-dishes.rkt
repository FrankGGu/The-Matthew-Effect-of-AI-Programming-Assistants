(define/contract (max-satisfaction satisfaction)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted (sort satisfaction >)]
         [n (length sorted)]
         [prefix (make-vector (add1 n) 0)]
         [total (make-vector (add1 n) 0)]
         [max-val 0])
    (for ([i (in-range 1 (add1 n))])
      (vector-set! prefix i (+ (vector-ref prefix (sub1 i)) (list-ref sorted (sub1 i))))
      (vector-set! total i (+ (vector-ref total (sub1 i)) (vector-ref prefix i)))
      (set! max-val (max max-val (vector-ref total i))))
    max-val))