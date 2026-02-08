(define exam-room%
  (class object%
    (super-new)
    (init-field n)
    (field [seats (make-hash)])

    (define/public (seat)
      (if (hash-empty? seats)
          (begin
            (hash-set! seats 0 #t)
            0)
          (let ([last-seat -1]
                [max-dist 0]
                [seat 0])
            (for ([s (sort (hash-keys seats) <)])
              (let ([dist (quotient (- s last-seat) 2)])
                (when (> dist max-dist)
                  (set! max-dist dist)
                  (set! seat (+ last-seat dist))))
              (set! last-seat s))
            (let ([dist (- n 1 last-seat)])
              (when (> dist max-dist)
                (set! seat (- n 1))))
            (hash-set! seats seat #t)
            seat)))

    (define/public (leave p)
      (hash-remove! seats p))))