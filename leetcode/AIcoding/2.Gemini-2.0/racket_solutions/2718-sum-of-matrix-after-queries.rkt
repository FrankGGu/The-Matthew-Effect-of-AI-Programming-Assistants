(define (sum-matrix-after-queries n queries)
  (let* ([row-set (make-hash)]
         [col-set (make-hash)]
         [row-count 0]
         [col-count 0]
         [sum 0])
    (for ([query (in-list (reverse queries))])
      (let ([type (first query)]
            [index (second query)]
            [val (third query)])
        (cond
          [(= type 0)
           (unless (hash-has-key? row-set index)
             (hash-set! row-set index #t)
             (set! row-count (+ row-count 1))
             (set! sum (+ sum (* (- n col-count) val))))]
          [else
           (unless (hash-has-key? col-set index)
             (hash-set! col-set index #t)
             (set! col-count (+ col-count 1))
             (set! sum (+ sum (* (- n row-count) val))))])))
    sum))