(define (h-index citations)
  (define sorted-citations (sort citations >))
  (let loop ([i 0] [citations sorted-citations])
    (if (or (null? citations) (< (car citations) (add1 i)))
        i
        (loop (add1 i) (cdr citations)))))