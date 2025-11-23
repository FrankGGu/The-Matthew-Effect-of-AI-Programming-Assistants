(define (most-points questions)
  (define n (length questions))
  (define dp (make-vector (add1 n) 0))

  (for/fold ((i (sub1 n))
             (dp dp))
            ((j (reverse (range n))))
    (let ((brainpower (list-ref (list-ref questions j) 1))
          (points (list-ref (list-ref questions j) 0)))
      (vector-set! dp j (max (+ points (vector-ref dp (min (+ j brainpower 1) n)))
                              (vector-ref dp (add1 j))))
      (values (sub1 i) dp)))

  (vector-ref dp 0))