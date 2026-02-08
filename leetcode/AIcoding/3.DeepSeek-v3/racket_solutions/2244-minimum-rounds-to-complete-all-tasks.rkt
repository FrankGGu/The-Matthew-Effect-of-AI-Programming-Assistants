(define/contract (minimum-rounds tasks)
  (-> (listof exact-integer?) exact-integer?)
  (let ([freq (make-hash)])
    (for ([task (in-list tasks)])
      (hash-update! freq task add1 0))
    (let loop ([res 0] [counts (hash-values freq)])
      (if (null? counts)
          res
          (let ([cnt (car counts)])
            (cond
              [(= cnt 1) -1]
              [else (loop (+ res (quotient (+ cnt 2) 3)) (cdr counts))]))))))