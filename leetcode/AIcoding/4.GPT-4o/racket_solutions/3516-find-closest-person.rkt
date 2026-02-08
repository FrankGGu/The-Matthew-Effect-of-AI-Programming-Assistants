(define (find-closest-person positions target)
  (let loop ((pos-list positions) (closest -1) (min-distance +inf.0))
    (cond
      [(null? pos-list) closest]
      [else
       (let* ((current (car pos-list))
              (distance (abs (- current target))))
         (if (< distance min-distance)
             (loop (cdr pos-list) current distance)
             (loop (cdr pos-list) closest min-distance)))))))

(define (findClosestPerson positions target)
  (find-closest-person positions target))