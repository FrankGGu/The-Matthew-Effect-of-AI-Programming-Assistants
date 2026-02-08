(define (count-squares matrix)
  (define m (length matrix))
  (define n (length (car matrix)))

  ;; dp table: vector of vectors
  (define dp (make-vector m #f))
  (for ([i (in-range m)])
    (vector-set! dp i (make-vector n 0)))

  (define total-squares 0)

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (when (= (list-ref (list-ref matrix i) j) 1)
        (let* ([current-dp-val
                (if (or (zero? i) (zero? j))
                    1
                    (+ 1 (min (vector-ref (vector-ref dp (- i 1)) j)
                              (vector-ref (vector-ref dp i) (- j 1))
                              (vector-ref (vector-ref dp (- i 1)) (- j 1)))))]
               )
          (vector-set! (vector-ref dp i) j current-dp-val)
          (set! total-squares (+ total-squares current-dp-val))))))

  total-squares)