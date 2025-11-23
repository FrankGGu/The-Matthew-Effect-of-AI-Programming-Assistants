(define (countPyramids land)
  (define n (length land))
  (define m (length (car land)))
  (define dp (make-vector n (make-vector m 0)))
  (define count 0)

  (for ([i (in-range n)])
    (for ([j (in-range m)])
      (when (= (list-ref (list-ref land i) j) 1)
        (if (or (= i 0) (= j 0) (= j (- m 1)))
            (vector-set! (vector-ref dp i) j 1)
            (let* ([left (vector-ref (vector-ref dp (- i 1)) (- j 1))]
                   [right (vector-ref (vector-ref dp (- i 1)) j)]
                   [down (vector-ref (vector-ref dp (- i 1)) (+ j 1))])
              (vector-set! (vector-ref dp i) j (+ 1 (min left (min right down))))))
        (set! count (+ count (vector-ref (vector-ref dp i) j))))))

  count)