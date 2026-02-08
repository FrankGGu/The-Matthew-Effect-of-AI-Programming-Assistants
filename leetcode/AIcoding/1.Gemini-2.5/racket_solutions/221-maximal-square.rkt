(define (maximal-square matrix)
  (define m (length matrix))
  (if (zero? m)
      0
      (begin
        (define n (length (car matrix)))
        (if (zero? n)
            0
            (let* ([dp (build-vector m (lambda (i) (build-vector n (lambda (j) 0))))]
                   [max-side 0])

              (for* ([i (in-range m)]
                     [j (in-range n)])
                (let ([char-val (list-ref (list-ref matrix i) j)])
                  (if (char=? char-val #\1)
                      (let ([current-dp-val
                             (if (or (zero? i) (zero? j))
                                 1
                                 (+ 1 (min (vector-ref (vector-ref dp (- i 1)) j)
                                           (vector-ref (vector-ref dp i) (- j 1))
                                           (vector-ref (vector-ref dp (- i 1)) (- j 1)))))]
                        (vector-set! (vector-ref dp i) j current-dp-val)
                        (set! max-side (max max-side current-dp-val)))
                      (vector-set! (vector-ref dp i) j 0)))))

              (* max-side max-side))))))