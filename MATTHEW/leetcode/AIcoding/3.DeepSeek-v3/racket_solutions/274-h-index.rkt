(define/contract (h-index citations)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([sorted (sort citations >)]
             [h 0])
    (if (or (null? sorted) (< (car sorted) (+ h 1)))
        h
        (loop (cdr sorted) (+ h 1)))))