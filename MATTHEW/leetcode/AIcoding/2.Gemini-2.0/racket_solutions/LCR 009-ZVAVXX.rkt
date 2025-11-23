(define (num-subarray-product-less-than-k nums k)
  (define n (length nums))
  (define (helper left right prod count)
    (cond
      [(>= right n) count]
      [else
       (let* ([new-prod (* prod (list-ref nums right))])
         (cond
           [(< new-prod k)
            (helper left (+ 1 right) new-prod (+ count (- (+ 1 right) left)))]
           [else
            (cond
              [(equal? left right)
               (helper (+ 1 left) (+ 1 right) 1 count)]
              [else
               (let loop ([l left] [p prod])
                 (cond
                   [(>= l right) (helper (+ 1 left) (+ 1 right) 1 count)]
                   [else
                    (let ([new-p (/ p (list-ref nums l))])
                      (if (< new-p k)
                          (helper (+ 1 l) (+ 1 right) new-p count)
                          (loop (+ 1 l) new-p))))]))]))]))))
  (if (<= k 1)
      0
      (helper 0 0 1 0)))