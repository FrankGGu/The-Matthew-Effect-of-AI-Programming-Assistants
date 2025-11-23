(define (remove-minimum-magic-beans beans)
  (define (helper beans)
    (cond [(null? beans) 0]
          [else
           (let* ([sorted (sort beans <)]
                  [n (length sorted)]
                  [total (apply + sorted)]
                  [min-ops (for/fold ([res (expt 10 18)]) ([i (in-range n)])
                             (min res (- total (* (list-ref sorted i) (- n i)))))]
           min-ops)]))
  (if (null? beans) 0 (helper beans)))