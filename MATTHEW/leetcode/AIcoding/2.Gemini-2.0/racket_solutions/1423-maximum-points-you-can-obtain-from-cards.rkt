(define (max-score card-points k)
  (define n (length card-points))
  (define prefix-sum (make-vector (+ n 1) 0))
  (for/list ((i (in-range n)))
    (vector-set! prefix-sum (+ i 1) (+ (vector-ref prefix-sum i) (list-ref card-points i))))

  (define (calculate-score left)
    (+ (vector-ref prefix-sum left)
       (- (vector-ref prefix-sum n) (vector-ref prefix-sum (- n (- k left))))))

  (let loop ((left 0) (max-so-far -inf.0))
    (cond
      ((> left k) max-so-far)
      (else (loop (+ left 1) (max max-so-far (calculate-score left)))))))