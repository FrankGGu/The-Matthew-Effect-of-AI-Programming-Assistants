#lang racket

(define (minimum-area-rectangle-ii points)
  (define num-points (length points))

  ; If fewer than 4 points, no rectangle can be formed.
  ; Return 0.0 as per problem statement for no rectangles.
  (when (< num-points 4)
    (if (zero? num-points)
        (void) ; For 0 points, the loops won't run, min-area will remain +inf.0, resulting in 0.0.
        0.0))  ; For 1, 2, or 3 points, return 0.0 directly.

  (define point-set (make-hash 'equal?))
  (for ([p points])
    (hash-set! point-set p #t))

  (define min-area +inf.0) ; Initialize with positive infinity

  (for ([i (range num-points)])
    (for ([j (range num-points)])
      (when (not (= i j)) ; Ensure P1 and P2 are distinct
        (for ([k (range num-points)])
          (when (and (not (= k i)) (not (= k j))) ; Ensure P3 is distinct from P1 and P2
            (let* ([p1 (list-ref points i)]
                   [p2 (list-ref points j)]
                   [p3 (list-ref points k)]

                   [x1 (first p1)] [y1 (second p1)]
                   [x2 (first p2)] [y2 (second p2)]
                   [x3 (first p3)] [y3 (second p3)]

                   ; Vectors P2-P1 and P3-P2
                   [v1x (- x2 x1)] [v1y (- y2 y1)]
                   [v2x (- x3 x2)] [v2y (- y3 y2)])

              ; Calculate squared lengths of the sides
              (let* ([side1-sq (+ (* v1x v1x) (* v1y v1y))]
                     [side2-sq (+ (* v2x v2x) (* v2y v2y))])

                ; Check for perpendicularity (dot product is zero)
                ; And ensure sides are not zero length (to avoid zero-area rectangles)
                (when (and (= (+ (* v1x v2x) (* v1y v2y)) 0)
                           (not (zero? side1-sq))
                           (not (zero? side2-sq)))
                  ; P1, P2, P3 form a right angle at P2
                  ; Calculate the fourth point P4 = P1 + (P3 - P2)
                  (let* ([p4x (+ x1 v2x)] ; x1 + (x3 - x2)
                         [p4y (+ y1 v2y)] ; y1 + (y3 - y2)
                         [p4 (list p4x p4y)])

                    ; Check if P4 exists in the original set of points
                    (when (hash-has-key? point-set p4)
                      (let ([current-area (* (sqrt side1-sq) (sqrt side2-sq))])
                        (set! min-area (min min-area current-area))))))))))))

  (if (= min-area +inf.0)
      0.0 ; If no rectangle found, return 0.0
      min-area))