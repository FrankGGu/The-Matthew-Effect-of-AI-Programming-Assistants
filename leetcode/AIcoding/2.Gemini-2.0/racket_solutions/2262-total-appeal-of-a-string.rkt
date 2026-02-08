(define (total-appeal s)
  (let* ([n (string-length s)]
         [dp (make-vector n 0)]
         [last (make-vector 26 -1)])
    (for ([i (in-range n)])
      (let* ([c (char->integer (string-ref s i))]
             [idx (- c (char->integer #\a))])
        (vector-set! dp i (+ i 1 (if (= (vector-ref last idx) -1)
                                     0
                                     (vector-ref dp (vector-ref last idx))))
        )
        (vector-set! last idx i)))
    (apply + (vector->list dp))))