(define (peopleAwareOfSecret n delay forget)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 1 1)
  (define total 0)

  (for ([i (in-range 1 (+ n 1))])
    (when (>= i delay)
      (define new-people (vector-ref dp (- i delay)))
      (vector-set! dp i (+ (vector-ref dp i) new-people)))
    (when (>= i forget)
      (vector-set! dp i (- (vector-ref dp i) (vector-ref dp (- i forget)))))
    (set! total (+ total (vector-ref dp i))))

  (remainder total 1000000007))

(define (numOfPeopleAwareOfSecret n delay forget)
  (peopleAwareOfSecret n delay forget))