(define (min-skips dist speed hoursBefore)
  (define n (length dist))
  (define dp (make-vector (+ n 1) (make-vector (+ n 1) #inf)))
  (vector-set! (vector-ref dp 0) 0 0)
  (for* ((i (in-range 1 (+ n 1)))
         (j (in-range 0 (+ n 1))))
    (let ((d (list-ref dist (- i 1))))
      (let ((t (/ (+ (vector-ref (vector-ref dp (- i 1) j) 0) d) speed)))
        (vector-set! (vector-ref dp i) j
                     (min (vector-ref (vector-ref dp i) j)
                          (+ (floor t) (- t (floor t))
                             (vector-ref (vector-ref dp (- i 1) j) 0))))
      (when (> j 0)
        (vector-set! (vector-ref dp i) j
                     (min (vector-ref (vector-ref dp i) j)
                          (+ d speed (vector-ref (vector-ref dp (- i 1) (- j 1)) 0)))))))
  (let loop ((j 0))
    (cond
      [(> j n) -1]
      [(<= (vector-ref (vector-ref dp n) j) hoursBefore) j]
      [else (loop (+ j 1))])))