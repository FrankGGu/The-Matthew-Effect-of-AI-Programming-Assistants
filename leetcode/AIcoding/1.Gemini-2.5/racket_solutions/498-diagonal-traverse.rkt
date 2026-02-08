(define (find-diagonal-order mat)
  (let* ([m (vector-length mat)]
         [n (vector-length (vector-ref mat 0))]
         [result (make-vector (* m n))]
         [r 0]
         [c 0]
         [is-up #t]
         [idx 0])

    (for ([_ (in-range (* m n))])
      (vector-set! result idx (vector-ref (vector-ref mat r) c))
      (set! idx (+ idx 1))

      (if is-up
          (let ([next-r (- r 1)]
                [next-c (+ c 1)])
            (if (or (< next-r 0) (>= next-c n))
                (begin
                  (set! is-up #f)
                  (if (>= next-c n)
                      (set! r (+ r 1))
                      (set! c (+ c 1))))
                (begin
                  (set! r next-r)
                  (set! c next-c))))
          (let ([next-r (+ r 1)]
                [next-c (- c 1)])
            (if (or (>= next-r m) (< next-c 0))
                (begin
                  (set! is-up #t)
                  (if (>= next-r m)
                      (set! c (+ c 1))
                      (set! r (+ r 1))))
                (begin
                  (set! r next-r)
                  (set! c next-c)))))
    result))