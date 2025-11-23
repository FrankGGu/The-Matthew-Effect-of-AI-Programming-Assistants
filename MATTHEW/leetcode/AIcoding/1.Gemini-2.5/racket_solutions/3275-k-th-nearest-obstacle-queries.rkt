(define (kth-nearest-obstacle-queries obstacles queries)
  (map (lambda (query)
         (let* ([qx (car query)]
                [qy (cadr query)]
                [qk (caddr query)])
           (let ([distances
                  (map (lambda (obstacle)
                         (let* ([ox (car obstacle)]
                                [oy (cadr obstacle)]
                                [dx (- qx ox)]
                                [dy (- qy oy)])
                           (+ (* dx dx) (* dy dy))))
                       obstacles)])
             (let ([num-obstacles (length distances)])
               (if (<= qk num-obstacles)
                   (list-ref (sort distances <) (- qk 1))
                   -1))))
       queries))