(define (can-transform-to-zero arr)
  (define (helper lst)
    (if (null? lst)
        #t
        (let ([first (car lst)]
              [rest (cdr lst)])
          (if (= first 0)
              (helper rest)
              (let loop ([r rest])
                (cond
                  [(null? r) #f]
                  [(= (car r) 0) (loop (cdr r))]
                  [else (if (zero? (+ first (car r)))
                            (or (helper (remove (car r) rest))
                                (loop (cdr r)))
                            (loop (cdr r)))]))))))
  (helper arr))

(define (zero-array-transformation arr)
  (can-transform-to-zero arr))