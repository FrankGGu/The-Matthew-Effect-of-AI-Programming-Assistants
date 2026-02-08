(define (print-vertically s)
  (define words (string-split s))
  (define max-len (apply max (map string-length words)))
  (define result (make-vector max-len ""))

  (for ([i (in-range max-len)])
    (for ([word words])
      (if (< i (string-length word))
          (vector-set! result i (string-append (vector-ref result i) (substring word i (+ i 1))))
          (vector-set! result i (string-append (vector-ref result i) " "))))
    (vector-set! result i (string-trim (vector-ref result i))))

  (vector->list result))