(define (minMeetingRooms intervals)
  (define (sort-intervals intervals)
    (sort intervals (lambda (a b) (< (car a) (car b)))))

  (define sorted-intervals (sort-intervals intervals))
  (define n (length sorted-intervals))

  (if (zero? n) 0)

  (define end-times (make-vector n 0))
  (define rooms 0)

  (for ([i (in-range n)])
    (define start (car (list-ref sorted-intervals i)))

    (define available-room -1)
    (for ([j (in-range rooms)])
      (when (and (> (vector-ref end-times j) start)
                 (or (= available-room -1) (< (vector-ref end-times available-room) (vector-ref end-times j))))
        (set! available-room j)))

    (if (>= available-room 0)
      (vector-set! end-times available-room (max (vector-ref end-times available-room) (cadr (list-ref sorted-intervals i))))
      (begin
        (vector-set! end-times rooms (cadr (list-ref sorted-intervals i)))
        (set! rooms (+ rooms 1)))))

  rooms)

(minMeetingRooms '((0 30) (5 10) (15 20)))