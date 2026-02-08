(define/contract (count-complete-day-pairs hours)
  (-> (listof exact-integer?) exact-integer?)
  (let ([count 0]
        [n (length hours)])
    (for ([i (in-range n)])
      (for ([j (in-range (add1 i) n)])
        (when (zero? (modulo (+ (list-ref hours i) (list-ref hours j)) 24))
          (set! count (add1 count)))))
    count))