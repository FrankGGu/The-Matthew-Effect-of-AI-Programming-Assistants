#lang racket

(struct point (x y) #:transparent)

(define EPSILON 1e-9) ; For floating point comparisons

(define (dist-sq p1 p2)
  (let* ((dx (- (point-x p1) (point-x p2)))
         (dy (- (point-y p1) (point-y p2))))
    (+ (* dx dx) (* dy dy))))

(define (point-add p1 p2)
  (point (+ (point-x p1) (point-x p2))
         (+ (point-y p1) (point-y p2))))

(define (point-sub p1 p2)
  (point (- (point-x p1) (point-x p2))
         (- (point-y p1) (point-y p2))))

(define (point-scale p s)
  (point (* (point-x p) s)
         (* (point-y p) s)))

(define (point-perp p) ; Rotates vector by 90 degrees counter-clockwise
  (point (- (point-y p)) (point-x p)))

(define (solve points r)
  (let* ((n (length points))
         (r-sq (* r r)))

    (when (zero? n)
      0) ; Problem constraints state 1 <= N <= 50, so this case is not strictly needed.

    (let loop-max-darts ((max-darts 1) ; At least one dart if there are points (N >= 1)
                         (i 0))
      (if (>= i n)
          max-darts
          (let* ((p1 (list-ref points i)))

            ; Helper to count darts for a given center
            (define (count-darts center)
              (let loop-k ((k 0) (count 0))
                (if (>= k n)
                    count
                    (let* ((pk (list-ref points k))
                           (dist-sq-to-center (dist-sq center pk)))
                      (loop-k (+ k 1)
                              (if (<= dist-sq-to-center (+ r-sq EPSILON)) ; Use r-sq for comparison with epsilon
                                  (+ count 1)
                                  count))))))

            ; Case 1: Circle centered at p1
            ; This covers cases where p1 is the center of an optimal circle.
            (let ((count-at-p1 (count-darts p1)))
              (let loop-j ((j (+ i 1)) ; Start j from i+1 to consider distinct pairs of points
                           (current-max-darts (max max-darts count-at-p1))) ; Update with count-at-p1
                (if (>= j n)
                    (loop-max-darts current-max-darts (+ i 1))
                    (let* ((p2 (list-ref points j))
                           (d-sq (dist-sq p1 p2))
                           (d (sqrt d-sq)))

                      ; If distance between p1 and p2 is greater than 2r,
                      ; a circle of radius r cannot pass through both points.
                      (if (> d (+ (* 2 r) EPSILON)) ; Use epsilon for comparison
                          (loop-j (+ j 1) current-max-darts)
                          (let* ((mid (point-scale (point-add p1 p2) 0.5))
                                 (h-sq (- r-sq (* 0.25 d-sq)))
                                 ; h is the distance from midpoint to circle center.
                                 ; Use (max 0.0 h-sq) to handle potential negative values due to floating point inaccuracies
                                 ; when d is very close to 2r.
                                 (h (sqrt (max 0.0 h-sq))))

                                 (vec-p1p2 (point-sub p2 p1))
                                 (perp-vec (point-perp vec-p1p2)))

                            ; The length of perp-vec is equal to the distance d between p1 and p2.
                            ; If d is 0 (p1 and p2 are geometrically the same point, due to duplicates in input),
                            ; unit-perp-vec becomes (0,0), leading to c1=c2=mid=p1.
                            (let* ((unit-perp-vec (if (> d EPSILON)
                                                      (point-scale perp-vec (/ d))
                                                      (point 0 0))))

                              (let* ((c1 (point-add mid (point-scale unit-perp-vec h)))
                                     (c2 (point-sub mid (point-scale unit-perp-vec h))))

                                (let ((count1 (count-darts c1))
                                      (count2 (count-darts c2)))
                                  (loop-j (+ j 1) (max current-max-darts count1 count2))))))))))))))