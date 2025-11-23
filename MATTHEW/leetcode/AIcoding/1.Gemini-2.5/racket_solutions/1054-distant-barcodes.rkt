(define (distant-barcodes barcodes)
  (define n (length barcodes))
  (when (zero? n)
    (list))

  (define freq-map (make-hash))
  (for-each (lambda (barcode)
              (hash-update! freq-map barcode add1 0))
            barcodes)

  (define sorted-freqs
    (sort (hash->list freq-map)
          (lambda (a b)
            (> (cdr a) (cdr b)))))

  (define result-vec (make-vector n #f))
  (define current-idx 0)

  (for-each (lambda (pair)
              (define barcode (car pair))
              (define count (cdr pair))
              (for ([_ (in-range count)])
                (vector-set! result-vec current-idx barcode)
                (set! current-idx (+ current-idx 2))
                (when (>= current-idx n)
                  (set! current-idx 1))))
            sorted-freqs)

  (vector->list result-vec))