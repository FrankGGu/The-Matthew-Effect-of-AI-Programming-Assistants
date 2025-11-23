(define (find-redundant-connection edges)
  (define n (add1 (apply max (apply append edges))))
  (define parent (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find x)
    (if (= x (vector-ref parent x))
        x
        (let ([root (find (vector-ref parent x))])
          (vector-set! parent x root)
          root)))

  (define (union x y)
    (let ([rootx (find x)]
          [rooty (find y)])
      (if (= rootx rooty)
          #f
          (begin
            (vector-set! parent rootx rooty)
            #t))))

  (for ([edge (in-list edges)])
    (let ([u (first edge)]
          [v (second edge)])
      (if (not (union u v))
          (return edge)))))