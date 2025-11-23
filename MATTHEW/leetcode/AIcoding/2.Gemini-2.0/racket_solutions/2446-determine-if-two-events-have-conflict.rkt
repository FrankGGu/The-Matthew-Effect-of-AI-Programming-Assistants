(define (have-conflict event1 event2)
  (define (time-to-minutes time)
    (+ (* (string->number (substring time 0 2)) 60) (string->number (substring time 3 5))))

  (define (conflict? start1 end1 start2 end2)
    (and (<= start1 end2) (<= start2 end1)))

  (conflict? (time-to-minutes (car event1)) (time-to-minutes (cadr event1))
            (time-to-minutes (car event2)) (time-to-minutes (cadr event2))))