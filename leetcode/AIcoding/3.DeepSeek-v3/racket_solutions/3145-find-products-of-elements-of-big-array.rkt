(define (product-of-elements big-array queries)
  (define (get-big-array-element k)
    (let loop ([n 1] [count 0])
      (let* ([bits (bitwise-bit-count n)]
             [new-count (+ count bits)])
        (if (>= new-count k)
            (let ([pos (- k count 1)])
              (bitwise-bit-field n pos (+ pos 1)))
            (loop (+ n 1) new-count)))))

  (define (compute-query query)
    (match query
      [(list l r mod)
       (let loop ([i l] [product 1])
         (if (> i r)
             (modulo product mod)
             (loop (+ i 1) (* product (get-big-array-element i)))))]))

  (map compute-query queries))