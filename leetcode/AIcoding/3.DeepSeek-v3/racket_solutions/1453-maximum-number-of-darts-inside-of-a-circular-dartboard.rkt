(define/contract (num-points-in-circle points r)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (define (distance p1 p2)
    (sqrt (+ (expt (- (first p1) (first p2)) 2)
             (expt (- (second p1) (second p2)) 2))))

  (define (get-center p1 p2)
    (let* ([x1 (first p1)]
           [y1 (second p1)]
           [x2 (first p2)]
           [y2 (second p2)]
           [d (distance p1 p2)]
      (if (> d (* 2 r))
          '()
          (let* ([mid-x (/ (+ x1 x2) 2.0)]
                 [mid-y (/ (+ y1 y2) 2.0)]
                 [h (sqrt (- (expt r 2) (expt (/ d 2) 2)))]
                 [dx (/ (- x2 x1) d)]
                 [dy (/ (- y2 y1) d)]
                 [c1 (list (+ mid-x (* h dy)) (- mid-y (* h dx)))]
                 [c2 (list (- mid-x (* h dy)) (+ mid-y (* h dx)))])
            (list c1 c2)))))

  (define (count-points center)
    (if (null? center)
        0
        (let ([x (first center)]
              [y (second center)]
              [count 0])
          (for ([p points])
            (when (<= (distance p center) (+ r 1e-6))
              (set! count (+ count 1)))
          count)))

  (define max-count 1)
  (define n (length points))

  (for ([i (in-range n)])
    (for ([j (in-range (+ i 1) n)])
      (let ([centers (get-center (list-ref points i) (list-ref points j))])
        (for ([center centers])
          (set! max-count (max max-count (count-points center))))))

  max-count)