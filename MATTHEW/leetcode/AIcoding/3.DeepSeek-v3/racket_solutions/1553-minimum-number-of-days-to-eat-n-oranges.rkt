(define/contract (min-days n)
  (-> exact-integer? exact-integer?)
  (let ([memo (make-hash)])
    (define (dp x)
      (cond
        [(<= x 1) x]
        [(hash-has-key? memo x) (hash-ref memo x)]
        [else
         (let* ([a (modulo x 2)]
                [b (modulo x 3)]
                [res (min (+ a 1 (dp (quotient x 2)))
                          (+ b 1 (dp (quotient x 3))))])
           (hash-set! memo x res)
           res)]))
    (dp n)))