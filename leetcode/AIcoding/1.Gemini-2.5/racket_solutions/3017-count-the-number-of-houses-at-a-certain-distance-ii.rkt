#lang racket

(define (count-the-number-of-houses-at-a-certain-distance-ii n x y)
  (let* ([actual-x (min x y)]
         [actual-y (max x y)])

    (define (d-circ a b)
      (let ([diff (abs (- a b))])
        (min diff (- n diff))))

    (define ans (make-vector n 0))

    (for ([i (in-range 1 (+ n 1))])
      (for ([j (in-range (+ i 1) (+ n 1))])
        (let ([dist-circular (d-circ i j)])
          (let ([dist-via-xy (+ (d-circ i actual-x) 1 (d-circ actual-y j))])
            (let ([dist-via-yx (+ (d-circ i actual-y) 1 (d-circ actual-x j))])
              (let ([min-dist (min dist-circular dist-via-xy dist-via-yx)])
                (vector-set! ans min-dist (+ (vector-ref ans min-dist) 1))))))))
    ans))