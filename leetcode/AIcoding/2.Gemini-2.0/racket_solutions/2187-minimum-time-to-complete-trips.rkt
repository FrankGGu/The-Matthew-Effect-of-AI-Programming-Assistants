(define (minimum-time trips times)
  (define (possible? t)
    (let loop ((times times) (count 0))
      (cond
        ((null? times) (>= count trips))
        (else (loop (cdr times) (+ count (floor (/ t (car times)))))))))

  (let loop ((l 1) (r (* trips (apply min times))))
    (if (<= l r)
        (let ((mid (floor (/ (+ l r) 2))))
          (if (possible? mid)
              (loop l (- mid 1))
              (loop (+ mid 1) r)))
        l)))