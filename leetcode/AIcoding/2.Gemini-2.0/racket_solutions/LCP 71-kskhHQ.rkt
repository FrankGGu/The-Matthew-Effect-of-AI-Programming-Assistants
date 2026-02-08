(define (trap height)
  (let* ([n (length height)]
         [left-max (make-vector n 0)]
         [right-max (make-vector n 0)])
    (if (zero? n)
        0
        (begin
          (vector-set! left-max 0 (vector-ref height 0))
          (for ([i (in-range 1 n)])
            (vector-set! left-max i (max (vector-ref left-max (- i 1)) (vector-ref height i))))

          (vector-set! right-max (- n 1) (vector-ref height (- n 1)))
          (for ([i (in-range (- n 2) -1 -1)])
            (vector-set! right-max i (max (vector-ref right-max (+ i 1)) (vector-ref height i))))

          (let loop ([i 0] [water 0])
            (if (= i n)
                water
                (let ([min-height (min (vector-ref left-max i) (vector-ref right-max i))])
                  (loop (+ i 1) (+ water (max 0 (- min-height (vector-ref height i)))))))))))))