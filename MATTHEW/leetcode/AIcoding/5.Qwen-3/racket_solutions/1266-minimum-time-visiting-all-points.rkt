#lang racket

(define/contract (min-time-to-visit-all-points points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (if (null? points)
      0
      (let loop ([points points] [time 0])
        (if (null? (cdr points))
            time
            (let* ([p1 (car points)]
                   [p2 (cadr points)]
                   [dx (abs (- (car p1) (car p2)))]
                   [dy (abs (- (cadr p1) (cadr p2)))]
                   [step (max dx dy)])
              (loop (cdr points) (+ time step)))))))