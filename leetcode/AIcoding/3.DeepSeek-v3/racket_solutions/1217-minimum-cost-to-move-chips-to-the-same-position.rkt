(define/contract (min-cost-to-move-chips position)
  (-> (listof exact-integer?) exact-integer?)
  (let ([even 0]
        [odd 0])
    (for ([pos position])
      (if (even? pos)
          (set! even (add1 even))
          (set! odd (add1 odd))))
    (min even odd)))