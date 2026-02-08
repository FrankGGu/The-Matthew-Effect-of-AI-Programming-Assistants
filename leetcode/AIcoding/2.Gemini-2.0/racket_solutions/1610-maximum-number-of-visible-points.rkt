(define (visible-points points angle location)
  (define (angle-between p1 p2)
    (atan (/ (- (cdr p2) (cdr p1)) (- (car p2) (car p1)))))

  (define angles
    (filter
     (lambda (a) (not (equal? a #f)))
     (map
      (lambda (p)
        (if (and (= (car p) (car location)) (= (cdr p) (cdr location)))
            #f
            (let ((ang (angle-between location p)))
              (cond
                [(>= ang 0) ang]
                [else (+ ang (* 2 pi))]))))
      points)))

  (define (max-visible sorted-angles)
    (let loop ((l sorted-angles) (r sorted-angles) (count 0) (max-count 0))
      (cond
        [(null? l) max-count]
        [else
         (let ((target-angle (+ (car l) (/ angle 180) pi)))
           (let ((r-new (drop-while (lambda (x) (< x target-angle)) r)))
             (let ((new-count (- (length sorted-angles) (length r-new) (length (drop-while (lambda (x) (> x (car l))) sorted-angles)))))
              (loop (cdr l) r (add1 count) (max max-count new-count)))))])))

  (if (null? angles)
      (length (filter (lambda (p) (and (= (car p) (car location)) (= (cdr p) (cdr location)))) points))
      (let ((sorted-angles (sort angles <)))
        (+ (length (filter (lambda (p) (and (= (car p) (car location)) (= (cdr p) (cdr location)))) points)) (max-visible sorted-angles)))))