(define/contract (minimum-boxes apple capacity)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([total-apples (apply + apple)]
         [sorted-capacity (sort capacity >)]
         [boxes 0]
         [remaining total-apples])
    (for ([cap sorted-capacity] #:break (<= remaining 0))
      (set! remaining (- remaining cap))
      (set! boxes (add1 boxes)))
    (if (<= remaining 0) boxes (length capacity))))