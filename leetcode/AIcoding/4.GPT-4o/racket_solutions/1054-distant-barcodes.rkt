(define (distant-barcode barcodes)
  (define (count-frequencies barcodes)
    (define freq (make-hash))
    (for-each (lambda (barcode)
                (hash-set! freq barcode (+ (hash-ref freq barcode 0) 1)))
              barcodes)
    freq)

  (define (sort-frequencies freq)
    (sort (hash->list freq) (lambda (a b) (> (second a) (second b)))))

  (define freq (count-frequencies barcodes))
  (define sorted (sort-frequencies freq))

  (define result (make-vector (vector-length barcodes)))
  (define n (vector-length barcodes))

  (define idx 0)
  (for-each (lambda (pair)
              (define barcode (first pair))
              (define count (second pair))
              (for ([i (in-range count)])
                (vector-set! result idx barcode)
                (set! idx (if (= idx (- n 1)) 1 (+ idx 2)))))
            sorted)

  (vector->list result))