(define (divide dividend divisor)
  (define (helper a b)
    (if (< a b)
        0
        (let ([shift 1]
              [tb b])
          (while (<= (arithmetic-shift tb shift) a)
            (set! shift (add1 shift)))
          (let ([shift (sub1 shift)])
            (+ (arithmetic-shift 1 shift)
               (helper (- a (arithmetic-shift b shift)) b)))))
  (let ([sign (if (xor (< dividend 0) (< divisor 0)) -1 1]
        [dividend (abs dividend)]
        [divisor (abs divisor)])
    (let ([res (helper dividend divisor)])
      (if (= sign -1)
          (- res)
          (if (> res 2147483647)
              2147483647
              res)))))