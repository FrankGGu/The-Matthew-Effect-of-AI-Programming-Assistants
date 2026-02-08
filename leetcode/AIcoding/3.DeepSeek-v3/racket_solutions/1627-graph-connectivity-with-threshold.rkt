(define/contract (are-connected n threshold queries)
  (-> exact-integer? exact-integer? (listof (listof exact-integer?)) (listof boolean?))
  (define parent (make-vector (+ n 1) 0))
  (define (find u)
    (if (zero? (vector-ref parent u))
        u
        (let ([p (find (vector-ref parent u))])
          (vector-set! parent u p)
          p)))
  (define (union u v)
    (let ([pu (find u)]
          [pv (find v)])
      (unless (equal? pu pv)
        (vector-set! parent pu pv))))
  (for* ([i (in-range (+ threshold 1) (+ n 1))]
         [j (in-range (* 2 i) (+ n 1) i)])
    (union i j))
  (for/list ([q (in-list queries)])
    (equal? (find (car q)) (find (cadr q)))))