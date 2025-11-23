(define/contract (find-missing-and-repeated-values grid)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (let* ([n (length grid)]
         [nums (flatten grid)]
         [counts (make-hash)])
    (for ([num nums])
      (hash-update! counts num add1 0))
    (define repeated 0)
    (define missing 0)
    (for ([i (in-range 1 (add1 (* n n)))])
      (define cnt (hash-ref counts i 0))
      (cond
        [(= cnt 2) (set! repeated i)]
        [(= cnt 0) (set! missing i)]))
    (list repeated missing)))