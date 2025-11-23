(define (minimum-time-removal cars)
  (define (helper cars time)
    (if (null? cars)
        time
        (let ((c (car cars)))
          (if (= c 1)
              (helper (cdr cars) (+ time 1))
              (helper (cdr cars) time)))))
  (helper cars 0))