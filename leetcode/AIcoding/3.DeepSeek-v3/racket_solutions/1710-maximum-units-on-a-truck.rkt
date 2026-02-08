(define/contract (maximum-units boxTypes truckSize)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let* ([sorted-boxes (sort boxTypes (lambda (a b) (> (second a) (second b))))]
         [units 0]
         [remaining truckSize])
    (for ([box sorted-boxes] #:break (<= remaining 0))
      (let ([take (min (first box) remaining)])
        (set! units (+ units (* take (second box))))
        (set! remaining (- remaining take))))
    units))