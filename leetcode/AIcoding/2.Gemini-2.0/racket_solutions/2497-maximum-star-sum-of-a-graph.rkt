(define (max-star-sum adj weights k)
  (define n (vector-length weights))
  (define sums (make-vector n 0))

  (for/list ([i (in-range n)])
    (let* ([neighbors (vector-ref adj i)]
           [neighbor-weights (sort (map (lambda (j) (vector-ref weights j)) neighbors) >)])
      (vector-set! sums i (vector-ref weights i))
      (for ([j (in-range (min k (length neighbor-weights)))])
        (when (> (list-ref neighbor-weights j) 0)
          (vector-set! sums i (+ (vector-ref sums i) (list-ref neighbor-weights j)))))))

  (apply max (vector->list sums)))

(define (max-star-sum-graph n edges weights k)
  (define adj (make-vector n '()))
  (for ([edge (in-list edges)])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (max-star-sum adj weights k))