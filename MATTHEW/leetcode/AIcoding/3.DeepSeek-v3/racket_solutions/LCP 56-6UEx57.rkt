(define/contract (deliver-items start end roads)
  (-> exact-nonnegative-integer? exact-nonnegative-integer? (listof (listof exact-nonnegative-integer?)) exact-nonnegative-integer?)
  (let* ([n (add1 (apply max (flatten roads)))]
         [graph (make-vector n '())]
         [dist (make-vector n +inf.0)]
         [visited (make-vector n #f)])
    (for ([road roads])
      (let ([u (first road)]
            [v (second road)]
            [w (third road)])
        (vector-set! graph u (cons (list v w) (vector-ref graph u)))
        (vector-set! graph v (cons (list u w) (vector-ref graph v))))
    (vector-set! dist start 0)
    (let loop ()
      (let ([u #f]
            [min-dist +inf.0])
        (for ([i (in-range n)])
        (for ([i (in-range n)])
          (when (and (not (vector-ref visited i))
                     (< (vector-ref dist i) min-dist))
            (set! u i)
            (set! min-dist (vector-ref dist i))))
        (when u
          (vector-set! visited u #t)
          (for ([edge (vector-ref graph u)])
          (for ([edge (vector-ref graph u)])
            (let ([v (first edge)]
                  [w (second edge)])
              (when (> (vector-ref dist v) (+ (vector-ref dist u) w))
                (vector-set! dist v (+ (vector-ref dist u) w)))))
          (loop))))
    (if (= (vector-ref dist end) +inf.0)
        -1
        (vector-ref dist end))))