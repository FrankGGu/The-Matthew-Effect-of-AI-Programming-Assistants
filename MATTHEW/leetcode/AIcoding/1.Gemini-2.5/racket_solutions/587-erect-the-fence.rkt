#lang racket

(define (erect-fence trees)
  (define num-trees (length trees))

  ;; Handle edge cases: 0, 1, or 2 points
  (cond
    ((= num-trees 0) '())
    ((= num-trees 1) trees)
    ((= num-trees 2)
     ;; If two points, they form the hull.
     ;; Since problem states points are unique, no need for set for uniqueness here, but good practice.
     trees)
    (else ; num-trees > 2, proceed with Monotone Chain algorithm
     ;; Sort points by x-coordinate, then by y-coordinate
     (define sorted-points
       (sort trees (lambda (p1 p2)
                     (let ((x1 (list-ref p1 0))
                           (y1 (list-ref p1 1))
                           (x2 (list-ref p2 0))
                           (y2 (list-ref p2 1)))
                       (or (< x1 x2)
                           (and (= x1 x2) (< y1 y2)))))))

     ;; Cross product function
     ;; Returns > 0 for CCW (left turn), < 0 for CW (right turn), 0 for collinear
     (define (cross-product p1 p2 p3)
       (let ((x1 (list-ref p1 0)) (y1 (list-ref p1 1))
             (x2 (list-ref p2 0)) (y2 (list-ref p2 1))
             (x3 (list-ref p3 0)) (y3 (list-ref p3 1)))
         (- (* (- x2 x1) (- y3 y1))
            (* (- y2 y1) (- x3 x1)))))

     ;; Build one half of the convex hull (upper or lower)
     ;; `points` is the list of points to process (forward for lower, reverse for upper)
     ;; The condition `(< (cross-product p1 p2 p) 0)` means pop if it's a strictly right turn.
     ;; This ensures that collinear points are included in the hull.
     (define (build-hull points)
       (reverse (foldl (lambda (p stack)
                         (let inner-loop ((s stack))
                           (if (< (length s) 2)
                               (cons p s)
                               (let ((p2 (car s)) (p1 (cadr s)))
                                 (if (< (cross-product p1 p2 p) 0)
                                     (inner-loop (cdr s)) ; Pop p2 (right turn)
                                     (cons p s)))))) ; Keep p2, add p (left turn or collinear)
                     '()
                     points)))

     ;; Build lower hull (processing sorted points in forward order)
     (define lower-hull (build-hull sorted-points))

     ;; Build upper hull (processing sorted points in reverse order)
     (define upper-hull (build-hull (reverse sorted-points)))

     ;; Combine hulls and remove duplicates
     ;; lower-hull goes from leftmost-lowest to rightmost-highest point.
     ;; upper-hull (after build-hull) goes from rightmost-highest to leftmost-lowest point.
     ;; We append lower-hull with upper-hull, excluding its first element (which is the rightmost-highest point, already in lower-hull).
     ;; The leftmost-lowest point (last element of upper-hull) will be a duplicate, handled by the set.
     (define combined-hull (append lower-hull (cdr upper-hull)))

     ;; Remove duplicates from the combined list using a set with `equal?` for point comparison
     (set->list (list->set combined-hull equal?)))))