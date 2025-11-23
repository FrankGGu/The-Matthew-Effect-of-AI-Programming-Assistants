(define (first-completely-painted-row-or-column mat)
  (define rows (vector (make-vector (vector-length (vector-ref mat 0)) #f) (vector-length mat)))
  (define cols (vector (make-vector (vector-length mat) #f) (vector-length (vector-ref mat 0))))
  (define painted-rows (make-vector (vector-length mat) #f))
  (define painted-cols (make-vector (vector-length (vector-ref mat 0)) #f))

  (for ([i (in-range (vector-length mat))])
    (for ([j (in-range (vector-length (vector-ref mat 0)))])
      (when (vector-ref (vector-ref mat i) j)
        (vector-set! painted-rows i #t)
        (vector-set! painted-cols j #t))))

  (for ([i (in-range (vector-length mat))])
    (when (vector-ref painted-rows i)
      (return i)))

  (for ([j (in-range (vector-length (vector-ref mat 0)))])
    (when (vector-ref painted-cols j)
      (return (+ (vector-length mat) j)))))

  -1)