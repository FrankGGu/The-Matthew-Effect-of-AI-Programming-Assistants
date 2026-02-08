(define (maximum-building-height n restrictions)
  (let* ((rs (sort restrictions (lambda (x y) (< (car x) (car y)))))
         (m (length rs))
         (heights (make-vector (+ m 2) 0)))

    (vector-set! heights 0 0)
    (vector-set! heights (+ m 1) n)

    (let loop ((i 0))
      (if (= i m)
          (void)
          (begin
            (vector-set! heights (+ i 1) (list-ref (list-ref rs i) 1))
            (loop (+ i 1)))))

    (let loop ((i 1))
      (if (> i (+ m 1))
          (void)
          (begin
            (vector-set! heights i (min (vector-ref heights i) (+ (vector-ref heights (- i 1)) (- (list-ref (list-ref rs (- i 2)) 0) (if (= i 1) 1 
                                                                                                                                (list-ref (list-ref rs (- i 2)) 0))  ) 1) ))
            (loop (+ i 1)))))

    (let loop ((i (- (+ m 1) 1)))
      (if (< i 0)
          (void)
          (begin
            (vector-set! heights i (min (vector-ref heights i) (+ (vector-ref heights (+ i 1)) (- (if (= i m) n
                                                                                                           (list-ref (list-ref rs i) 0)) (if (= i -1) 1
                                                                                                                                            (list-ref (list-ref rs (max 0 (- i 1))) 0))) 1)))
            (loop (- i 1)))))

    (let loop ((i 0) (max-height 0))
      (if (= i (+ m 1))
          max-height
          (let* ((pos1 (if (= i 0) 1 (list-ref (list-ref rs (- i 1)) 0)))
                 (pos2 (if (= i m) n (list-ref (list-ref rs i) 0)))
                 (height1 (vector-ref heights i))
                 (height2 (vector-ref heights (+ i 1)))
                 (dist (- pos2 pos1))
                 (height-diff (abs (- height2 height1)))
                 (peak-height (+ (max height1 height2) (floor (- dist height-diff) 2))))
            (loop (+ i 1) (max max-height peak-height)))))))