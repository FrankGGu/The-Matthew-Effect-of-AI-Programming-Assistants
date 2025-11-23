(define (find-circle-num is-connected)
  (let* ([n (vector-length is-connected)]
         [parent (make-vector n 0)]
         [count n])
    (define (find u)
      (if (= (vector-ref parent u) u)
          u
          (let ([p (find (vector-ref parent u))])
            (vector-set! parent u p)
            p)))
    (define (union u v)
      (let ([pu (find u)]
            [pv (find v)])
        (unless (= pu pv)
          (vector-set! parent pu pv)
          (set! count (- count 1)))))
    (for ([i (in-range n)])
      (vector-set! parent i i))
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (when (= (vector-ref (vector-ref is-connected i) j) 1)
          (union i j))))
    count))