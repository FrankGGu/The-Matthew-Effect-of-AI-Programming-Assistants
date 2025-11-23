(define SeatManager
  (lambda (n)
    (let ([available (make-vector n #t)]
          [reserved (make-hash)])
      (define (reserve)
        (for ([i (in-range n)])
          (when (vector-ref available i)
            (vector-set! available i #f)
            (hash-set! reserved (add1 i) #t)
            (return (add1 i))))
        (error "No available seats"))

      (define (unreserve seatNumber)
        (hash-remove! reserved seatNumber)
        (vector-set! available (sub1 seatNumber) #t))

      (define (getAvailableSeats)
        (let loop ([i 0] [count 0])
          (if (< i n)
              (if (vector-ref available i)
                  (loop (add1 i) (add1 count))
                  (loop (add1 i) count)
              )
              count)))

      (define (getReservedSeats)
        (hash-keys reserved))

      (define (reserveSeat)
        (reserve))

      (define (unreserveSeat seatNumber)
        (unreserve seatNumber))

      (list reserveSeat unreserveSeat getAvailableSeats getReservedSeats))))