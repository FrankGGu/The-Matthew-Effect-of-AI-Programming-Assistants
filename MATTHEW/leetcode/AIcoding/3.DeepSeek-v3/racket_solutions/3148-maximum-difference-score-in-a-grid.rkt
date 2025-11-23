(define/contract (max-score grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([m (length grid)]
         [n (length (first grid))]
         [dp (make-vector m (make-vector n -inf.0))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (vector-set! (vector-ref dp i) j (list-ref (list-ref grid i) j))))
    (let loop ([i 0] [j 0] [max-score -inf.0])
      (cond
        [(>= i m) max-score]
        [(>= j n) (loop (add1 i) 0 max-score)]
        [else
         (let ([current (vector-ref (vector-ref dp i) j)])
           (for* ([k (in-range i m)]
                  [l (in-range j n)]
                  #:when (or (> k i) (> l j)))
             (let ([new-score (+ current (- (vector-ref (vector-ref dp k) l)))])
               (when (> new-score (vector-ref (vector-ref dp k) l))
                 (vector-set! (vector-ref dp k) l new-score))
               (set! max-score (max max-score new-score))))
           (loop i (add1 j) max-score))])))))