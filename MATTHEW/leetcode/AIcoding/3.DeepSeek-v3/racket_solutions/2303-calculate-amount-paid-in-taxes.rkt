(define/contract (calculate-tax brackets income)
  (-> (listof (listof exact-integer?)) exact-integer? flonum?)
  (let loop ([remaining income]
             [prev 0]
             [i 0]
             [tax 0.0])
    (if (or (>= i (length brackets)) (<= remaining 0))
        tax
        (let* ([current (list-ref brackets i)]
               [upper (first current)]
               [percent (second current)]
               [taxable (min (- upper prev) remaining)])
          (loop (- remaining taxable)
                upper
                (+ i 1)
                (+ tax (* taxable (/ percent 100.0))))))))