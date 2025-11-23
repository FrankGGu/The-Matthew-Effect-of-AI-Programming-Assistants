#lang racket

(struct DetectSquares (points-map))

(define (DetectSquares-new)
  (DetectSquares (hash)))

(define (DetectSquares-add ds point)
  (let* ([x (car point)]
         [y (cadr point)]
         [points-map (DetectSquares-points-map ds)]
         [current-x-map (hash-ref points-map x (hash))])
    (hash-set! current-x-map y (+ (hash-ref current-x-map y 0) 1))
    (hash-set! points-map x current-x-map)))

(define (DetectSquares-count ds point)
  (let* ([x1 (car point)]
         [y1 (cadr point)]
         [total-squares 0])
    (for ([(x_other y_map_other) (in-hash (DetectSquares-points-map ds))])
      (when (not (= x1 x_other))
        (for ([(y_other count_other) (in-hash y_map_other)])
          (when (not (= y1 y_other))
            (when (= (abs (- x1 x_other)) (abs (- y1 y_other)))
              (let* ([p3_x x1]
                     [p3_y y_other]
                     [p4_x x_other]
                     [p4_y y1]
                     [p3_x_map (hash-ref (DetectSquares-points-map ds) p3_x (hash))]
                     [p4_x_map (hash-ref (DetectSquares-points-map ds) p4_x (hash))]
                     [p3_count (hash-ref p3_x_map p3_y 0)]
                     [p4_count (hash-ref p4_x_map p4_y 0)])
                (set! total-squares (+ total-squares (* p3_count p4_count)))))))))
    total-squares))