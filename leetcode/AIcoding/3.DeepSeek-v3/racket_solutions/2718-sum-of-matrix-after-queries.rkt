(define/contract (matrix-sum-queries n queries)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (define rows (make-hash))
  (define cols (make-hash))
  (define row-sum 0)
  (define col-sum 0)
  (define total 0)
  (for ([query (reverse queries)])
    (match query
      [(list type index val)
       (cond
         [(= type 0)
          (unless (hash-has-key? rows index)
            (hash-set! rows index #t)
            (set! row-sum (+ row-sum val))
            (set! total (+ total (* val (- n (hash-count cols))))))]
         [else
          (unless (hash-has-key? cols index)
            (hash-set! cols index #t)
            (set! col-sum (+ col-sum val))
            (set! total (+ total (* val (- n (hash-count rows))))))])]))
  total)