(define (assign-cookies g s)
  (define (solve g s count)
    (cond
      [(or (null? g) (null? s)) count]
      [else
       (let ([sorted-g (sort g <)]
             [sorted-s (sort s <)])
         (define (helper sorted-g sorted-s count)
           (cond
             [(or (null? sorted-g) (null? sorted-s)) count]
             [((<= (car sorted-g) (car sorted-s)))
              (helper (cdr sorted-g) (cdr sorted-s) (+ count 1))]
             [else
              (helper sorted-g (cdr sorted-s) count)]))
         (helper sorted-g sorted-s count))]))
  (solve g s 0))