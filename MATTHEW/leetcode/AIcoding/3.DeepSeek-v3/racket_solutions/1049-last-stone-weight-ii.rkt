(define/contract (last-stone-weight-ii stones)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([total (apply + stones)]
         [target (quotient total 2)]
         [n (length stones)]
         [dp (make-vector (add1 target) #f)])
    (vector-set! dp 0 #t)
    (for ([stone (in-list stones)])
      (for ([i (in-range target (sub1 stone) -1)])
        (when (vector-ref dp (- i stone))
          (vector-set! dp i #t)))
    (let loop ([i target])
      (if (vector-ref dp i)
          (- total (* 2 i))
          (loop (sub1 i))))))