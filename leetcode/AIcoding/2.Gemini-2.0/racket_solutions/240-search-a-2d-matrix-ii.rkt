(define (search-matrix matrix target)
  (define (search-row row)
    (let loop ((left 0) (right (sub1 (vector-length row))))
      (cond
        ((> left right) #f)
        (else
         (let ((mid (floor (/ (+ left right) 2))))
           (cond
             ((= (vector-ref row mid) target) #t)
             ((< (vector-ref row mid) target) (loop (add1 mid) right))
             (else (loop left (sub1 mid)))))))))

  (and (not (null? matrix))
       (or* (map search-row matrix))))