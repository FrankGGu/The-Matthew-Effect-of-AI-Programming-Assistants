(define/contract (rotate-right head k)
  (-> (or/c list? null?) exact-nonnegative-integer? (or/c list? null?))
  (if (null? head)
      null
      (let* ([len (length head)]
             [k (modulo k len)]
             [split-point (- len k)]
             [tail-part (take head split-point)]
             [head-part (drop head split-point)])
        (append head-part tail-part))))