(define (maximal-square matrix)
  (cond
    [(null? matrix) 0]
    [(null? (car matrix)) 0]
    [else
     (let* ([rows (length matrix)]
            [cols (length (car matrix))]
            [dp (make-vector (+ rows 1) (make-vector (+ cols 1) 0))]
            [max-side 0])
       (for* ([i (in-range 1 (+ rows 1))]
              [j (in-range 1 (+ cols 1))])
         (when (= (list-ref (list-ref matrix (- i 1)) (- j 1)) '1')
           (vector-set! (vector-ref dp i) j
                        (+ 1 (min (vector-ref (vector-ref dp (- i 1)) (- j 1))
                                  (vector-ref (vector-ref dp (- i 1)) j)
                                  (vector-ref (vector-ref dp i) (- j 1)))))
           (set! max-side (max max-side (vector-ref (vector-ref dp i) j)))))
       (* max-side max-side))]))