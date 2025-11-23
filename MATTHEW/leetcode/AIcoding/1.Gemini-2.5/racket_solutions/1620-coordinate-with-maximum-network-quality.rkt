#lang racket

(define (coordinate-with-maximum-network-quality towers radius)
  (let* ([max-quality -1]
         [best-x 0]
         [best-y 0])
    (for ([x (in-range 51)])
      (for ([y (in-range 51)])
        (let ([current-quality 0])
          (for ([tower towers])
            (let* ([tx (list-ref tower 0)]
                   [ty (list-ref tower 1)]
                   [tq (list-ref tower 2)]
                   [dx (- x tx)]
                   [dy (- y ty)]
                   [dist-sq (+ (* dx dx) (* dy dy))]
                   [dist (sqrt dist-sq)])
              (when (<= dist radius)
                (set! current-quality (+ current-quality (floor (/ tq (+ 1 dist))))))))

          (when (> current-quality max-quality)
            (set! max-quality current-quality)
            (set! best-x x)
            (set! best-y y))

          (when (and (= current-quality max-quality)
                     (or (< x best-x)
                         (and (= x best-x) (< y best-y))))
            (set! best-x x)
            (set! best-y y)))))
    (list best-x best-y)))