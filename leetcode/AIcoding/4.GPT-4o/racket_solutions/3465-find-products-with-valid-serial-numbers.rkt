(define (findValidSerialNumbers serials)
  (define (is-valid? serial)
    (and (string? serial)
         (not (string-empty? serial))
         (string? (string->number serial))))
  (filter is-valid? serials))

(define (findProductsWithValidSerialNumbers serials)
  (findValidSerialNumbers serials))