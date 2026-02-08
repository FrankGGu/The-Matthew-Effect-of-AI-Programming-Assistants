(define (generate-matrix n)
  (if (= n 0)
      '()
      (let* ([matrix (build-vector n (lambda (i) (build-vector n (lambda (j) 0))))]
             [top 0]
             [bottom (- n 1)]
             [left 0]
             [right (- n 1)]
             [num 1])
        (let loop ()
          (when (and (<= top bottom) (<= left right))
            ;; Traverse right
            (for ([c (in-range left (add1 right))])
              (vector-set! (vector-ref matrix top) c num)
              (set! num (add1 num)))
            (set! top (add1 top))

            ;; Traverse down
            (when (<= top bottom)
              (for ([r (in-range top (add1 bottom))])
                (vector-set! (vector-ref matrix r) right num)
                (set! num (add1 num)))
              (set! right (sub1 right)))

            ;; Traverse left
            (when (and (<= top bottom) (<= left right))
              (for ([c (in-range right (sub1 left) -1)])
                (vector-set! (vector-ref matrix bottom) c num)
                (set! num (add1 num)))
              (set! bottom (sub1 bottom)))

            ;; Traverse up
            (when (and (<= top bottom) (<= left right))
              (for ([r (in-range bottom (sub1 top) -1)])
                (vector-set! (vector-ref matrix r) left num)
                (set! num (add1 num)))
              (set! left (add1 left)))
            (loop)))
        (for/list ([row matrix])
          (vector->list row)))))