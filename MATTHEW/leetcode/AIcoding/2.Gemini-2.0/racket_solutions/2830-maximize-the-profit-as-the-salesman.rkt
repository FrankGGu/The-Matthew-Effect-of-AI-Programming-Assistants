(define (maximize-the-profit n offers)
  (define dp (make-vector (+ n 1) 0))
  (define sorted-offers (sort offers (lambda (a b) (< (car a) (car b)))))

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i (vector-ref dp (- i 1)))
    (for ([offer (in-list sorted-offers)])
      (let ([start (car offer)]
            [end (cadr offer)]
            [price (caddr offer)])
        (when (= end i)
          (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp start) price)))))))
  (vector-ref dp n))