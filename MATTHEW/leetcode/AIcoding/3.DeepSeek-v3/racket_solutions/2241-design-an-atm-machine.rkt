(define atm-machine%
  (class object%
    (super-new)

    (init-field)
    (field [banknotes (make-vector 5 0)]
           [values (vector 20 50 100 200 500)])

    (define/public (deposit banknotesCount)
      (for ([i (in-range 5)])
        (vector-set! banknotes i (+ (vector-ref banknotes i) (vector-ref banknotesCount i)))))

    (define/public (withdraw amount)
      (let ([result (make-vector 5 0)]
            [remaining amount])
        (for ([i (in-range 4 -1 -1)])
          (let ([val (vector-ref values i)]
                [count (vector-ref banknotes i)])
            (let ([take (min count (quotient remaining val))])
              (set! remaining (- remaining (* take val)))
              (vector-set! result i take)))
        (if (zero? remaining)
            (begin
              (for ([i (in-range 5)])
                (vector-set! banknotes i (- (vector-ref banknotes i) (vector-ref result i))))
              (vector->list result))
            '(-1))))))