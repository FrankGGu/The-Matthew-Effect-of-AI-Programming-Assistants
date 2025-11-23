(define/contract (max-operations nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([count 0]
        [freq (make-hash)])
    (for ([num nums])
      (define complement (- k num))
      (if (and (hash-has-key? freq complement) (> (hash-ref freq complement) 0))
          (begin
            (set! count (+ count 1))
            (hash-update! freq complement sub1))
          (hash-update! freq num add1 0)))
    count))