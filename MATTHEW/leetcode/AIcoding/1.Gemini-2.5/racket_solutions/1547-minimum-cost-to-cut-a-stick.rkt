(define (min-cost-cut n cuts)
  (let* ([all-cuts (sort (cons 0 (cons n cuts)) <)]
         [m (length all-cuts)]
         [dp (make-vector m (lambda () (make-vector m 0)))])

    (for ([len (in-range 2 m)])
      (for ([i (in-range 0 (- m len))])
        (let ([j (+ i len)])
          (vector-set! (vector-ref dp i) j +inf.0)
          (for ([k (in-range (+ i 1) j)])
            (let* ([cost-current-segment (- (list-ref all-cuts j) (list-ref all-cuts i))]
                   [cost-left (vector-ref (vector-ref dp i) k)]
                   [cost-right (vector-ref (vector-ref dp k) j)]
                   [total-cost (+ cost-current-segment cost-left cost-right)])
              (when (< total-cost (vector-ref (vector-ref dp i) j))
                (vector-set! (vector-ref dp i) j total-cost)))))))

    (vector-ref (vector-ref dp 0) (- m 1))))