(define (insert intervals newInterval)
  (let loop ((intervals intervals)
             (acc '())
             (current-new newInterval)
             (added-new #f))
    (cond
      ((empty? intervals)
       (if added-new
           (reverse acc)
           (reverse (cons current-new acc))))
      (else
       (let ((interval (car intervals)))
         (cond
           ((and (not added-new) (< (second interval) (first current-new)))
            (loop (rest intervals) (cons interval acc) current-new added-new))
           ((> (first interval) (second current-new))
            (if added-new
                (loop (rest intervals) (cons interval acc) current-new added-new)
                (loop (rest intervals) (cons interval (cons current-new acc)) current-new #t)))
           (else
            (loop (rest intervals)
                  acc
                  (list (min (first current-new) (first interval))
                        (max (second current-new) (second interval)))
                  added-new))))))))