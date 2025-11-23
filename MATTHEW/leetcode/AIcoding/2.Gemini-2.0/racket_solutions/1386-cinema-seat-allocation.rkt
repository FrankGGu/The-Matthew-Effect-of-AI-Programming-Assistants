(define (cinema-seat-allocation n reserved-seats)
  (let* ((seats (make-hash))
         (process-reservation
          (lambda (reservation)
            (let ((row (car reservation))
                  (col (cdr reservation)))
              (hash-update! seats row (lambda (v) (if v (cons col v) (list col))) '()))))
         (available-seats 0))

    (for-each process-reservation reserved-seats)

    (for ([i (in-range 1 (+ n 1))])
      (let ((reserved (hash-ref seats i '())))
        (cond
          [(and (not (member 2 reserved)) (not (member 3 reserved)) (not (member 4 reserved)) (not (member 5 reserved))
                (not (member 6 reserved)) (not (member 7 reserved)) (not (member 8 reserved)) (not (member 9 reserved))))
           (set! available-seats (+ available-seats 2))]
          [(and (not (member 2 reserved)) (not (member 3 reserved)) (not (member 4 reserved)) (not (member 5 reserved))))
           (set! available-seats (+ available-seats 1))]
          [(and (not (member 6 reserved)) (not (member 7 reserved)) (not (member 8 reserved)) (not (member 9 reserved))))
           (set! available-seats (+ available-seats 1))]
          [(and (not (member 4 reserved)) (not (member 5 reserved)) (not (member 6 reserved)) (not (member 7 reserved))))
           (set! available-seats (+ available-seats 1))]
          [else #f])))

    available-seats))