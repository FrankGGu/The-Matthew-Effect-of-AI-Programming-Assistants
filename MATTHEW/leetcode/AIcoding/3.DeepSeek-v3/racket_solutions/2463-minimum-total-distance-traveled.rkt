(define/contract (minimum-total-distance robot factory)
  (-> (listof exact-integer?) (listof (listof exact-integer?)) exact-integer?)
  (let* ([robot (sort robot <)]
         [factory (sort factory (lambda (a b) (< (car a) (car b))))]
         [m (length robot)]
         [n (length factory)]
         [dp (make-vector (add1 m) +inf.0)])
    (vector-set! dp 0 0)
    (for ([fac factory])
      (let ([pos (car fac)]
            [limit (cadr fac)])
        (for ([k (in-range m (sub1 0) -1)])
          (let loop ([j 1] [cost 0])
            (when (and (<= j limit) (<= j k))
              (set! cost (+ cost (abs (- (list-ref robot (sub1 k)) pos)))
              (vector-set! dp k (min (vector-ref dp k) (+ (vector-ref dp (- k j)) cost)))
              (loop (add1 j) cost))))))
    (inexact->exact (vector-ref dp m))))