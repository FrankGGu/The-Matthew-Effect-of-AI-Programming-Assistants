(define/contract (max-frequency-elements nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([freq (make-hash)]
         [max-freq 0]
         [count 0])
    (for ([num nums])
      (hash-update! freq num add1 0)
      (define current (hash-ref freq num))
      (cond
        [(> current max-freq) (set! max-freq current) (set! count current)]
        [(= current max-freq) (set! count (+ count current))]))
    count))