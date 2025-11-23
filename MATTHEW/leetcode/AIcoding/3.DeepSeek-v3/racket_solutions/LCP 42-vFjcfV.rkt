#lang racket

(define (numPoints points r)
  (define (distance x1 y1 x2 y2)
    (sqrt (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2))))

  (define (count-in-circle x y)
    (for/sum ([p (in-list points)])
      (if (<= (distance (car p) (cadr p) x y) r) 1 0)))

  (define max-count 0)
  (for* ([p1 (in-list points)]
         [p2 (in-list points)]
         #:unless (equal? p1 p2))
    (let* ((x1 (car p1))
           (y1 (cadr p1))
           (x2 (car p2))
           (y2 (cadr p2))
           (d (distance x1 y1 x2 y2)))
      (when (<= d (* 2 r))
        (let* ((mid-x (/ (+ x1 x2) 2))
               (mid-y (/ (+ y1 y2) 2))
               (h (sqrt (- (expt r 2) (expt (/ d 2) 2))))
               (dx (/ (- x2 x1) d))
               (dy (/ (- y2 y1) d))
          (let ((center-x1 (+ mid-x (* h (- dy))))
                (center-y1 (- mid-y (* h dx))))
            (set! max-count (max max-count (count-in-circle center-x1 center-y1))))
          (let ((center-x2 (- mid-x (* h (- dy))))
                (center-y2 (+ mid-y (* h dx))))
            (set! max-count (max max-count (count-in-circle center-x2 center-y2)))))))
  (if (zero? max-count) 1 max-count))