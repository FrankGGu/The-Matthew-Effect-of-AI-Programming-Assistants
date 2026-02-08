(define/contract (max-frequency-elements nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([freq (make-hash)]
         [max-freq 0]
         [count 0])
    (for ([num nums])
      (hash-update! freq num add1 (lambda () 0))
      (define current (hash-ref freq num))
      (cond
        [(> current max-freq) (set! max-freq current)
                              (set! count 1)]
        [(= current max-freq) (set! count (add1 count))]))
    (* max-freq count)))