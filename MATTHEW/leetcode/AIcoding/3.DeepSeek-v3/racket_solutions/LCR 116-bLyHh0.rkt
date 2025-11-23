(define (find-circle-num is-connected)
  (let* ([n (length is-connected)]
         [parent (build-vector n (lambda (i) i))]
         [count n])
    (define (find u)
      (if (not (= (vector-ref parent u) u))
          (begin
            (vector-set! parent u (find (vector-ref parent u)))
            (vector-ref parent u))
          u))
    (define (union u v)
      (let ([root-u (find u)]
            [root-v (find v)])
        (when (not (= root-u root-v))
          (vector-set! parent root-u root-v)
          (set! count (- count 1)))))
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (when (= (list-ref (list-ref is-connected i) j) 1)
          (union i j)))
    count))