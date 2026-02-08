(define SeatManager%
  (class object%
    (init-field n)
    (define seats (make-vector n #f))
    (define available (list))

    (define/public (init n)
      (set! n n)
      (set! seats (make-vector n #f))
      (set! available (for/list ((i (in-range 1 (+ n 1)))) i)))

    (define/public (reserve)
      (let ((seat (car available)))
        (set! available (cdr available))
        (vector-set! seats (- seat 1) #t)
        seat))

    (define/public (unreserve seatNumber)
      (vector-set! seats (- seatNumber 1) #f)
      (let loop ((lst available))
        (cond
          ((null? lst) (set! available (list seatNumber)))
          ((< seatNumber (car lst)) (set! available (cons seatNumber lst)))
          (else (set! available (cons (car lst) (loop (cdr lst)))))))))
    ))

(define (SeatManager n)
  (instantiate SeatManager% (init-field n)))