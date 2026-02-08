(define (construct-grid mat)
  (define n (length mat))
  (define m (if (null? mat) 0 (length (car mat))))
  (define result (make-vector n (make-vector m #f)))

  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (vector-set! (vector-ref result i) j (vector-ref (vector-ref mat i) j))))

  result)

(define (grid-matching mat)
  (construct-grid mat))