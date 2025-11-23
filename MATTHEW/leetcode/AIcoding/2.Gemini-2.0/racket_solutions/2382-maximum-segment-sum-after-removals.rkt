(define (maximum-segment-sum-after-removals nums remove-queries)
  (define n (length nums))
  (define parent (make-vector n))
  (define size (make-vector n 1))
  (define sum (make-vector n))
  (define result '())
  (define max-sum 0)

  (for ([i (in-range n)])
    (vector-set! parent i i)
    (vector-set! sum i 0))

  (define (find x)
    (if (equal? (vector-ref parent x) x)
        x
        (let ([root (find (vector-ref parent x))])
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (let* ([root-x (find x)]
           [root-y (find y)])
      (if (not (equal? root-x root-y))
          (begin
            (if (> (vector-ref size root-x) (vector-ref size root-y))
                (begin
                  (vector-set! parent root-y root-x)
                  (vector-set! size root-x (+ (vector-ref size root-x) (vector-ref size root-y)))
                  (vector-set! sum root-x (+ (vector-ref sum root-x) (vector-ref sum root-y)))
                  (set! max-sum (max max-sum (vector-ref sum root-x))))
                (begin
                  (vector-set! parent root-x root-y)
                  (vector-set! size root-y (+ (vector-ref size root-y) (vector-ref size root-x)))
                  (vector-set! sum root-y (+ (vector-ref sum root-y) (vector-ref sum root-x)))
                  (set! max-sum (max max-sum (vector-ref sum root-y))))))))))

  (define removed (make-vector n #f))

  (for ([query (reverse remove-queries)])
    (push! result max-sum)
    (vector-set! removed query #t)
    (vector-set! sum query (list-ref nums query))
    (set! max-sum (max max-sum (vector-ref sum query)))

    (if (and (> query 0) (vector-ref removed (- query 1)))
        (union query (- query 1)))
    (if (and (< query (- n 1)) (vector-ref removed (+ query 1)))
        (union query (+ query 1)))))

  (reverse result))