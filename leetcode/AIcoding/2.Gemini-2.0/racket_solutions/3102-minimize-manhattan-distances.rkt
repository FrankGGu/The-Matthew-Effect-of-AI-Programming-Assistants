(define (min-manhattan-distance points)
  (define xs (map car points))
  (define ys (map cdr points))
  (define (median lst)
    (let ((sorted-lst (sort lst <)))
      (let ((len (length sorted-lst)))
        (if (odd? len)
            (list-ref sorted-lst (floor (/ len 2)))
            (/ (+ (list-ref sorted-lst (sub1 (/ len 2)))
                  (list-ref sorted-lst (/ len 2)))
               2.0)))))

  (define median-x (median xs))
  (define median-y (median ys))

  (define (total-distance x y)
    (foldl + 0 (map (lambda (p) (+ (abs (- (car p) x)) (abs (- (cdr p) y)))) points)))

  (total-distance median-x median-y))