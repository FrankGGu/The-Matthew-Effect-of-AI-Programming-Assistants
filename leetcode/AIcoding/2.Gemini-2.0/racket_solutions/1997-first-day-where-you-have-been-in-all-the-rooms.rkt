(define (first-day-been-in-all-rooms next-visit)
  (define n (vector-length next-visit))
  (define visited (make-vector n #f))
  (define current-day 0)
  (define current-room 0)
  (vector-set! visited 0 #t)
  (define visited-count 1)

  (define (step)
    (if (= visited-count n)
        current-day
        (begin
          (let ((next-room (if (even? current-day)
                                (+ current-room (vector-ref next-visit current-room))
                                (- current-room (vector-ref next-visit current-room)))))
            (define next-room-mod (modulo next-room n))
            (set! current-day (+ current-day 1))
            (set! current-room next-room-mod)
            (if (not (vector-ref visited current-room))
                (begin
                  (vector-set! visited current-room #t)
                  (set! visited-count (+ visited-count 1))))
            (step)))))

  (modulo (step) (+ 1000000000 7)))