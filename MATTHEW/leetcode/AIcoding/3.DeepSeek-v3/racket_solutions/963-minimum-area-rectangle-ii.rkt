(define/contract (min-area-free-rect points)
  (-> (listof (listof exact-integer?)) flonum?)
  (let* ([n (length points)]
         [midpoints (make-hash)]
         [min-area +inf.0])
    (for ([i (in-range n)])
      (for ([j (in-range (add1 i) n)])
        (let* ([p1 (list-ref points i)]
               [p2 (list-ref points j)]
               [dx (- (first p2) (first p1))]
               [dy (- (second p2) (second p1))]
               [l (+ (* dx dx) (* dy dy))]
               [cx (/ (+ (first p1) (first p2)) 2.0)]
               [cy (/ (+ (second p1) (second p2)) 2.0)]
               [key (list l cx cy)])
          (hash-update! midpoints key (lambda (v) (cons (list i j) v)) '())))
    (for ([(key pairs) (in-hash midpoints)])
      (let ([m (length pairs)])
        (when (>= m 2)
          (for ([k (in-range m)])
            (for ([l (in-range (add1 k) m)])
              (let* ([pair1 (list-ref pairs k)]
                     [pair2 (list-ref pairs l)]
                     [i1 (first pair1)]
                     [j1 (second pair1)]
                     [i2 (first pair2)]
                     [j2 (second pair2)]
                     [p1 (list-ref points i1)]
                     [p2 (list-ref points j1)]
                     [p3 (list-ref points i2)]
                     [dx1 (- (first p2) (first p1))]
                     [dy1 (- (second p2) (second p1))]
                     [dx2 (- (first p3) (first p1))]
                     [dy2 (- (second p3) (second p1))]
                     [dot (+ (* dx1 dx2) (* dy1 dy2))])
                (when (zero? dot)
                  (let ([len1 (sqrt (+ (* dx1 dx1) (* dy1 dy1)))]
                    [len2 (sqrt (+ (* dx2 dx2) (* dy2 dy2)))]
                    [area (* len1 len2)])
                      (set! min-area (min min-area area)))))))))
    (if (= min-area +inf.0) 0.0 min-area)))