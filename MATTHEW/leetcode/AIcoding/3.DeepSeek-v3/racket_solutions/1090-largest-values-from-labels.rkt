(define/contract (largest-vals-from-labels values labels numWanted useLimit)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let* ([pairs (sort (map cons values labels) > #:key car)]
         [label-count (make-hash)]
         [selected 0]
         [sum 0])
    (for ([pair (in-list pairs)]
          #:break (>= selected numWanted)
          (let ([val (car pair)]
                [lbl (cdr pair)])
            (define cnt (hash-ref label-count lbl 0))
            (when (< cnt useLimit)
              (set! sum (+ sum val))
              (set! selected (add1 selected))
              (hash-set! label-count lbl (add1 cnt)))))
    sum))