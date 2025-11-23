(define (escape-ghosts ghosts)
  (let ((target '(0 0)))
    (let loop ((g ghosts) (dist 0))
      (if (null? g)
          #t
          (let ((g-pos (car g)))
            (if (<= (+ (abs (car g-pos)) (abs (cadr g-pos))) dist)
                #f
                (loop (cdr g) dist)))))))