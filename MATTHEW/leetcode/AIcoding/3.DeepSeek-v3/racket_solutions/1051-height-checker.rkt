(define/contract (height-checker heights)
  (-> (listof exact-integer?) exact-integer?)
  (let ([sorted (sort heights <)])
    (for/sum ([h heights] [s sorted] #:when (not (= h s))) 1))