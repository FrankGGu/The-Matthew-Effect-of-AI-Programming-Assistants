(define (block-placement-queries n blocks queries)
  (define blocks-arr (make-vector n #f))
  (define result (make-vector (length queries) #f))

  (for ([i (in-range (length blocks))])
    (vector-set! blocks-arr (vector-ref blocks i) #t))

  (for ([i (in-range (length queries))])
    (define query (vector-ref queries i))
    (define type (vector-ref query 0))
    (define index (vector-ref query 1))

    (cond
      [(= type 1)
       (if (vector-ref blocks-arr index)
           (vector-set! result i #f)
           (begin
             (vector-set! blocks-arr index #t)
             (vector-set! result i #t)))]
      [else
       (vector-set! blocks-arr index #f)
       (vector-set! result i #t)]))

  (list->vector (map (lambda (x) (if x 1 0)) (vector->list result))))