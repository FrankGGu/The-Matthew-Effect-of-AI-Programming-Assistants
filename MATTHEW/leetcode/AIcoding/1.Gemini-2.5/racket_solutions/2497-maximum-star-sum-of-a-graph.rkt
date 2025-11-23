(define (maximum-star-sum vals edges k)
  (define n (length vals))
  (define vals-vec (list->vector vals))

  (define adj-vec (make-vector n '()))

  (for-each
   (lambda (edge)
     (define u (car edge))
     (define v (cadr edge))
     (vector-set! adj-vec u (cons v (vector-ref adj-vec u)))
     (vector-set! adj-vec v (cons u (vector-ref adj-vec v))))
   edges)

  (define max-sum (apply max vals))

  (for ([i (in-range n)])
    (define current-center-val (vector-ref vals-vec i))
    (define neighbors-indices (vector-ref adj-vec i))

    (define positive-neighbor-vals
      (filter (lambda (val) (> val 0))
              (map (lambda (neighbor-idx) (vector-ref vals-vec neighbor-idx))
                   neighbors-indices)))

    (define sorted-positive-neighbor-vals
      (sort positive-neighbor-vals >))

    (define top-k-neighbor-vals
      (take sorted-positive-neighbor-vals k))

    (define current-star-sum
      (+ current-center-val
         (apply + 0 top-k-neighbor-vals)))

    (set! max-sum (max max-sum current-star-sum)))

  max-sum)