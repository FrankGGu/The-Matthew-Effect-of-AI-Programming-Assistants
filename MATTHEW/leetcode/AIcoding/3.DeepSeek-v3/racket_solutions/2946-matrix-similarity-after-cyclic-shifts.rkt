(define (are-matrices-similar? mat k)
  (let* ([m (length mat)]
         [n (length (car mat))]
         [shifted-mat (for/list ([i (in-range m)])
                        (let ([row (list-ref mat i)])
                        (if (even? i)
                            (let ([shift (modulo k n)])
                              (append (drop row shift) (take row shift)))
                            (let ([shift (modulo k n)])
                              (append (take-right row shift) (drop-right row shift))))])
    (equal? mat shifted-mat)))