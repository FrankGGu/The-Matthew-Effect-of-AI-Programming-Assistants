(define (min-trio-degree n edges)
  (define adj (make-vector (add1 n) '()))
  (define degrees (make-vector (add1 n) 0))
  (define matrix (make-vector (add1 n) #f))
  (for ([i (in-range (add1 n))])
    (vector-set! matrix i (make-vector (add1 n) #f)))

  (for ([edge (in-list edges)])
    (let* ([u (car edge)]
           [v (cadr edge)])
      (vector-set! degrees u (add1 (vector-ref degrees u)))
      (vector-set! degrees v (add1 (vector-ref degrees v)))
      (vector-set! matrix u (vector-set! (vector-ref matrix u) v #t))
      (vector-set! matrix v (vector-set! (vector-ref matrix v) u #t))))

  (define min-degree #f)
  (for* ([i (in-range 1 (add1 n))]
         [j (in-range (add1 i) (add1 n))]
         [k (in-range (add1 j) (add1 n))])
    (when (and (vector-ref (vector-ref matrix i) j)
               (vector-ref (vector-ref matrix i) k)
               (vector-ref (vector-ref matrix j) k))
      (let ([degree (+ (vector-ref degrees i)
                       (vector-ref degrees j)
                       (vector-ref degrees k)
                       -6)])
        (set! min-degree (if min-degree (min min-degree degree) degree)))))

  (if min-degree min-degree -1))