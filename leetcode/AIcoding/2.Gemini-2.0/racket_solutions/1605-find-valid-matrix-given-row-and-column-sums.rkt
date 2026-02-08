(define (restoreMatrix rowSum colSum)
  (let* ([n (length rowSum)]
         [m (length colSum)]
         [matrix (make-vector n (make-vector m 0))])
    (for ([i (in-range n)])
      (for ([j (in-range m)])
        (let ([val (min (vector-ref rowSum i) (vector-ref colSum j))])
          (vector-set! (vector-ref matrix i) j val)
          (vector-set! rowSum i (- (vector-ref rowSum i) val))
          (vector-set! colSum j (- (vector-ref colSum j) val)))))
    (list->matrix (vector->list matrix))))

(define (list->matrix lst)
  (map vector->list lst))