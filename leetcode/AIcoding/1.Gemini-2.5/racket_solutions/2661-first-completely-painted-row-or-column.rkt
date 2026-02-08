(define (first-completely-painted-row-or-column arr mat)
  (let* ((m (length mat))
         (n (length (car mat)))
         (num-to-coords (make-hash))
         (row-counts (make-vector m 0))
         (col-counts (make-vector n 0)))

    (for ([r (in-range m)]
          [row mat])
      (for ([c (in-range n)]
            [val row])
        (hash-set! num-to-coords val (list r c))))

    (for/first ([k (in-range (length arr))]
                [num arr])
      (let* ((coords (hash-ref num-to-coords num))
             (r (car coords))
             (c (cadr coords)))

        (vector-set! row-counts r (+ (vector-ref row-counts r) 1))
        (vector-set! col-counts c (+ (vector-ref col-counts c) 1))

        (when (or (= (vector-ref row-counts r) n)
                  (= (vector-ref col-counts c) m))
          k)))))