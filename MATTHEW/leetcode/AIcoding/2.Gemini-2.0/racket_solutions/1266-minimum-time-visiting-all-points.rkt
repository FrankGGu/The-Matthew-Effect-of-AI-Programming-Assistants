(define (min-time-to-visit-all-points points)
  (let loop ((points points) (time 0))
    (if (null? (cdr points))
        time
        (let ((p1 (car points)) (p2 (cadr points)))
          (let ((dx (abs (- (car p1) (car p2))))
                (dy (abs (- (cadr p1) (cadr p2)))))
            (loop (cdr points) (+ time (max dx dy))))))))