(define (max-points points r)
  (let* ((n (length points))
         (max-count 1))
    (define (count-points center)
      (let loop ([points points] [count 0])
        (if (null? points)
            count
            (let ([p (car points)])
              (if (<= (sqrt (+ (sqr (- (car p) (car center)))
                                 (sqr (- (cadr p) (cadr center)))))
                      r)
                  (loop (cdr points) (+ count 1))
                  (loop (cdr points) count))))))

    (define (solve p1 p2)
      (let ([x1 (car p1)] [y1 (cadr p1)]
            [x2 (car p2)] [y2 (cadr p2)])
        (let ([d (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2))))])
          (if (> d (* 2.0 r))
              0
              (let* ([mid-x (/ (+ x1 x2) 2.0)]
                     [mid-y (/ (+ y1 y2) 2.0)]
                     [dist (sqrt (- (sqr r) (sqr (/ d 2.0))))]
                     [dx (* dist (/ (- y2 y1) d))]
                     [dy (* dist (/ (- x1 x2) d))]
                     [center1 (list (+ mid-x dx) (+ mid-y dy))]
                     [center2 (list (- mid-x dx) (- mid-y dy))]
                     [count1 (count-points center1)]
                     [count2 (count-points center2)])
                (max count1 count2))))))

    (for* ([i (in-range n)]
           [j (in-range (+ i 1) n)])
      (set! max-count (max max-count (solve (list-ref points i) (list-ref points j)))))

    max-count))