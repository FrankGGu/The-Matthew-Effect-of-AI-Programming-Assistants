(define (repair-cars ranks cars)
  (define (possible-time time)
    (let loop ((ranks ranks) (cars cars))
      (cond
        ((zero? cars) #t)
        ((null? ranks) #f)
        (else
          (let ((rank (car ranks)))
            (let ((count (floor (/ (sqrt (/ time rank)) 1))))
              (if (>= count cars)
                  #t
                  (loop (cdr ranks) (- cars count)))))))))

  (define (binary-search left right)
    (if (<= left right)
        (let ((mid (floor (/ (+ left right) 2))))
          (if (possible-time mid)
              (binary-search left (- mid 1))
              (binary-search (+ mid 1) right))
          )
        left))

  (let ((max-rank (apply max ranks)))
      (binary-search 0 (* max-rank (* cars cars)))))