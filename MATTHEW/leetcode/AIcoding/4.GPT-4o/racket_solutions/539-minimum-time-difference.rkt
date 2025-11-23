(define (find-min-time-difference time-points)
  (define (to-minutes time)
    (let* ([parts (string-split time ":")]
           [hours (string->number (car parts))]
           [minutes (string->number (cadr parts))])
      (+ (* hours 60) minutes)))

  (define minutes-list (map to-minutes time-points))
  (define sorted-minutes (sort minutes-list <))
  (define n (length sorted-minutes))

  (define min-diff (foldl (lambda (current min-so-far)
                             (min min-so-far (modulo (- current (car sorted-minutes)) 1440)))
                           (modulo (+ (- (car sorted-minutes) (last sorted-minutes)) 1440) 1440)
                           (cdr sorted-minutes)))

  min-diff)

(define (findMinDifference time-points)
  (find-min-time-difference time-points))