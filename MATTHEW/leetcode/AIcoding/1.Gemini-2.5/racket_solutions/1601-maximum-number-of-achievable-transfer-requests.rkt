(define (maximum-requests n requests)
  (let* ([m (length requests)]
         [max-requests 0])
    (for ([i (in-range 0 (expt 2 m))])
      (let* ([current-requests-count 0]
             [balance (make-vector n 0)])
        (for ([j (in-range 0 m)])
          (when (logbit? j i)
            (set! current-requests-count (+ current-requests-count 1))
            (let* ([request (list-ref requests j)]
                   [from (car request)]
                   [to (cadr request)])
              (vector-set! balance from (- (vector-ref balance from) 1))
              (vector-set! balance to (+ (vector-ref balance to) 1)))))
        (let ([is-valid? #t])
          (for ([k (in-range 0 n)])
            (when (not (= (vector-ref balance k) 0))
              (set! is-valid? #f)
              (break)))
          (when is-valid?
            (set! max-requests (max max-requests current-requests-count))))))
    max-requests))