(define/contract (convert-unit from-unit to-unit quantity conversion-table)
  (-> string? string? exact-integer? (listof (list string? string? exact-integer? exact-integer?)) exact-integer?)
  (let ([graph (make-hash)])
    (for ([conv conversion-table])
      (let ([u1 (first conv)]
            [u2 (second conv)]
            [n (third conv)]
            [d (fourth conv)])
        (hash-update! graph u1 (lambda (lst) (cons (list u2 n d) lst)) '())
        (hash-update! graph u2 (lambda (lst) (cons (list u1 d n) lst)) '())))

    (let loop ([visited (set)]
               [current from-unit]
               [value quantity]
               [denominator 1])
      (cond
        [(equal? current to-unit) (/ value denominator)]
        [(set-member? visited current) -1]
        [else
         (let ([neighbors (hash-ref graph current '())]
               [found -1])
           (for ([neighbor neighbors] #:break (not (= found -1)))
             (let ([next-unit (first neighbor)]
                   [n (second neighbor)]
                   [d (third neighbor)])
               (set! found (loop (set-add visited current)
                                next-unit
                                (* value n)
                                (* denominator d))))
           found)]))))