(define (bicycleRace cars maxSpeed)
  (define (count-finishers speed)
    (length (filter (lambda (x) (>= x speed)) cars)))
  (define (find-best-speed speed)
    (if (null? speed)
        0
        (let ((current-speed (car speed)))
          (let ((current-finishers (count-finishers current-speed)))
            (if (> current-finishers (find-best-speed (cdr speed)))
                current-speed
                (find-best-speed (cdr speed)))))))
  (find-best-speed (range 1 (+ 1 maxSpeed))))