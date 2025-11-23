(define (heater-distance a h)
  (let loop ((i 0) (min-dist #f))
    (if (= i (length h))
        min-dist
        (let ((dist (abs (- a (list-ref h i)))))
          (loop (+ i 1) (if (or (not min-dist) (< dist min-dist)) dist min-dist))))))

(define (find-radius houses heaters)
  (let ((sorted-heaters (sort heaters <)))
    (let loop ((i 0) (min-radius 0))
      (if (= i (length houses))
          min-radius
          (let* ((house (list-ref houses i))
                 (dist (heater-distance house sorted-heaters)))
            (loop (+ i 1) (max min-radius dist)))))))