(define (num-ways n relations k)
  (define dp (build-list (+ k 1) (lambda (_) (make-vector n 0))))

  (vector-set! (list-ref dp 0) 0 1)

  (for ([s (in-range k)])
    (for ([relation relations])
      (define src (list-ref relation 0))
      (define dest (list-ref relation 1))

      (define ways-at-src (vector-ref (list-ref dp s) src))

      (when (> ways-at-src 0)
        (vector-set! (list-ref dp (+ s 1))
                     dest
                     (+ (vector-ref (list-ref dp (+ s 1)) dest) ways-at-src)))))

  (vector-ref (list-ref dp k) (- n 1)))