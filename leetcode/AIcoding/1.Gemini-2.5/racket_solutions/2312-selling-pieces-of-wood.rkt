(define (selling-pieces-of-wood n m prices)
  (define dp (make-vector (+ n 1) (lambda () (make-vector (+ m 1) 0))))

  (define piece-prices (make-vector (+ n 1) (lambda () (make-vector (+ m 1) 0))))
  (for-each (lambda (p)
              (define h (car p))
              (define w (cadr p))
              (define price (caddr p))
              (when (and (<= h n) (<= w m))
                (vector-set! (vector-ref piece-prices h) w
                             (max (vector-ref (vector-ref piece-prices h) w) price))))
            prices)

  (for ([h (in-range 1 (+ n 1))])
    (for ([w (in-range 1 (+ m 1))])
      (vector-set! (vector-ref dp h) w (vector-ref (vector-ref piece-prices h) w))

      (for ([i (in-range 1 h)])
        (vector-set! (vector-ref dp h) w
                     (max (vector-ref (vector-ref dp h) w)
                          (+ (vector-ref (vector-ref dp i) w)
                             (vector-ref (vector-ref dp (- h i)) w)))))

      (for ([j (in-range 1 w)])
        (vector-set! (vector-ref dp h) w
                     (max (vector-ref (vector-ref dp h) w)
                          (+ (vector-ref (vector-ref dp h) j)
                             (vector-ref (vector-ref dp h) (- w j))))))))

  (vector-ref (vector-ref dp n) m))