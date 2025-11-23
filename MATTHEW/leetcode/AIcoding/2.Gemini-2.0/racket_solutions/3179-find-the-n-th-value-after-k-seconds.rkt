(define (find-nth-value nums k n)
  (let* [(len (length nums))
         (effective-k (modulo k len))
         (index (modulo (+ n effective-k -1) len))]
    (list-ref nums index)))