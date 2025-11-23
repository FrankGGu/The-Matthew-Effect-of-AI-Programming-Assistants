(define (min-meeting-rooms meetings)
  (let* ((arrivals (sort (map car meetings) <))
         (departures (sort (map cdr meetings) <)))
    (let loop ((i 0) (j 0) (rooms 0) (max-rooms 0))
      (cond
        ((= i (length arrivals)) max-rooms)
        ((<= (list-ref arrivals i) (list-ref departures j))
         (loop (+ i 1) j (+ rooms 1) (max max-rooms (+ rooms 1))))
        (else
         (loop i (+ j 1) (- rooms 1) max-rooms))))))

(define (min-meeting-chairs arrivals departures)
  (min-meeting-rooms (map list arrivals departures)))