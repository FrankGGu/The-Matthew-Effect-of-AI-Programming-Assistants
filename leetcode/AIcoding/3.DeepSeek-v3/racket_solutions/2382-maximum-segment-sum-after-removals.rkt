(define (maximum-segment-sum nums removeQueries)
  (let* ([n (length nums)]
         [parent (make-vector n -1)]
         [sum (make-vector n 0)]
         [res (make-list (length removeQueries) 0)]
         [max-sum 0])
    (define (find u)
      (if (= (vector-ref parent u) -1)
          u
          (let ([p (find (vector-ref parent u))])
            (vector-set! parent u p)
            p)))
    (define (union u v)
      (let ([pu (find u)]
            [pv (find v)])
        (when (not (= pu pv))
          (vector-set! parent pv pu)
          (vector-set! sum pu (+ (vector-ref sum pu) (vector-ref sum pv)))
          (set! max-sum (max max-sum (vector-ref sum pu)))))
    (for ([i (in-range (- n 1) -1 -1)])
      (let ([pos (list-ref removeQueries i)])
        (vector-set! sum pos (list-ref nums pos))
        (set! max-sum (max max-sum (vector-ref sum pos)))
        (when (and (> pos 0) (not (= (vector-ref parent (- pos 1)) -1)))
          (union pos (- pos 1)))
        (when (and (< pos (- n 1)) (not (= (vector-ref parent (+ pos 1)) -1))))
          (union pos (+ pos 1)))
        (list-set! res i max-sum))
    res))