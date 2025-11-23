(define/contract (minimum-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([unique-non-zero (remove-duplicates (filter (lambda (x) (not (zero? x))) nums))])
    (length unique-non-zero)))