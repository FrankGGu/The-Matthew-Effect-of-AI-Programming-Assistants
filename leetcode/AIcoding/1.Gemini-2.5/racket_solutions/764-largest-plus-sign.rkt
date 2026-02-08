(define (largest-plus-sign N mines)
  (define grid (make-vector N (lambda () (make-vector N 1))))

  (for ([mine mines])
    (define r (vector-ref mine 0))
    (define c (vector-ref mine 1))
    (vector-set! (vector-ref grid r) c 0))

  (define left (make-vector N (lambda () (make-vector N 0))))
  (define right (make-vector N (lambda () (make-vector N 0))))
  (define up (make-vector N (lambda () (make-vector N 0))))
  (define down (make-vector N (lambda () (make-vector N 0))))

  (for ([r (in-range N)])
    (for ([c (in-range N)])
      (when (= (vector-ref (vector-ref grid r) c) 1)
        (vector-set! (vector-ref left r) c
                     (if (> c 0)
                         (+ 1 (vector-ref (vector-ref left r) (- c 1)))
                         1))
        (vector-set! (vector-ref up r) c
                     (if (> r 0)
                         (+ 1 (vector-ref (vector-ref up (- r 1)) c))
                         1)))))

  (for ([r (in-range N -1 -1)])
    (for ([c (in-range N -1 -1)])
      (when (= (vector-ref (vector-ref grid r) c) 1)
        (vector-set! (vector-ref right r) c
                     (if (< c (- N 1))
                         (+ 1 (vector-ref (vector-ref right r) (+ c 1)))
                         1))
        (vector-set! (vector-ref down r) c
                     (if (< r (- N 1))
                         (+ 1 (vector-ref (vector-ref down (+ r 1)) c))
                         1)))))

  (define max-order 0)
  (for ([r (in-range N)])
    (for ([c (in-range N)])
      (when (= (vector-ref (vector-ref grid r) c) 1)
        (set! max-order (max max-order
                             (min (vector-ref (vector-ref left r) c)
                                  (vector-ref (vector-ref right r) c)
                                  (vector-ref (vector-ref up r) c)
                                  (vector-ref (vector-ref down r) c)))))))
  max-order)