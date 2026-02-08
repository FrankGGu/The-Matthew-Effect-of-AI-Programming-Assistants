(define/contract (pass-the-pillow n time)
  (-> exact-integer? exact-integer? exact-integer?)
  (let* ([cycle (* 2 (- n 1))]
         [remainder (modulo time cycle)])
    (if (<= remainder (- n 1))
        (+ 1 remainder)
        (- n (- remainder (- n 1)) 1))))
)