(define (minimum-time-to-remove-cars cars)
  (define (helper cars)
    (if (null? cars)
        0
        (let* ((first-car (car cars))
               (remaining-cars (cdr cars))
               (time-if-remove-first (+ (if (= first-car 1) 1 0) (helper remaining-cars))))
          (time-if-remove-first))))
  (helper cars))

(minimum-time-to-remove-cars '(1 0 1 0 1))