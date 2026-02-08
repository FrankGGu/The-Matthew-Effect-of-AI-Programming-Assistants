(define (at-most-n-given-digit-set digits n)
  (let* ([s (number->string n)]
         [len (string-length s)]
         [digits (sort digits char<?)]
         [m (length digits)])
    (define (count-less c)
      (let loop ([low 0] [high (sub1 m)])
        (if (> low high)
            0
            (let ([mid (quotient (+ low high) 2)])
              (if (char<? (list-ref digits mid) c)
                  (loop (add1 mid) high)
                  (loop low (sub1 mid)))))))
    (define (count-equal i)
      (if (>= i len)
          1
          (let ([c (string-ref s i)]
                [cnt (count-less c)])
            (+ (* cnt (expt m (- len i 1)))
               (if (member c digits)
                   (count-equal (add1 i))
                   0)))))
    (let ([total 0])
      (for ([i (in-range 1 len)])
        (set! total (+ total (expt m i))))
      (+ total (count-equal 0)))))