(define (stone-game-ii piles)
  (let* ([n (length piles)]
         [dp (make-vector (* n n) 0)]
         [sum (make-vector n 0)])
    (vector-set! sum (- n 1) (list-ref piles (- n 1)))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! sum i (+ (list-ref piles i) (vector-ref sum (+ i 1)))))
    (let loop ([i (- n 1)] [m 1])
      (cond
        [(>= i n) 0]
        [(>= (* 2 m) (- n i)) (vector-ref sum i)]
        [else
         (let ([max-stones 0])
           (for ([x (in-range 1 (+ (* 2 m) 1))])
             (when (<= (+ i x) n)
               (let ([current-stones (- (vector-ref sum i)
                                        (if (>= (+ i x) n)
                                            0
                                            (vector-ref (* (+ i x) (+ i x)) (min (max m x) n))))])
                 (when (> current-stones max-stones)
                   (set! max-stones current-stones)))))
           max-stones)])))))