(define (ways-to-split-array-into-good-subarrays nums)
  (define MOD 1000000007)
  (define n (vector-length nums))

  (define ones-indices '())
  (for ([i (in-range n)])
    (when (= (vector-ref nums i) 1)
      (set! ones-indices (append ones-indices (list i)))))

  (cond
    [(empty? ones-indices) 0]
    [(= (length ones-indices) 1) 1]
    [else
     (define result 1)
     (define current-one-index (car ones-indices))
     (for ([next-one-index (cdr ones-indices)])
       (define gap-length (- next-one-index current-one-index))
       (set! result (modulo (* result gap-length) MOD))
       (set! current-one-index next-one-index))
     result]))