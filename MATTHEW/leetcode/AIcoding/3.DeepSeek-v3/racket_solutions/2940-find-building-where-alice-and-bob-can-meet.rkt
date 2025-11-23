(define/contract (leftmost-building-queries heights queries)
  (-> (listof exact-integer?) (listof (listof exact-integer?)) (listof exact-integer?))
  (define n (length heights))
  (define max-heights (make-vector n 0))
  (vector-set! max-heights (sub1 n) (list-ref heights (sub1 n)))
  (for ([i (in-range (- n 2) -1 -1)])
    (vector-set! max-heights i (max (list-ref heights i) (vector-ref max-heights (add1 i)))))

  (define (solve-query a b)
    (let ([x (min a b)]
          [y (max a b)])
      (cond
        [(= x y) y]
        [(< (list-ref heights x) (list-ref heights y)) y]
        [else
         (let loop ([lo y] [hi (sub1 n)])
           (if (> lo hi)
               -1
               (let ([mid (quotient (+ lo hi) 2)])
                 (if (> (vector-ref max-heights mid) (list-ref heights x))
                     (loop lo mid)
                     (loop (add1 mid) hi)))))])))

  (map solve-query queries))