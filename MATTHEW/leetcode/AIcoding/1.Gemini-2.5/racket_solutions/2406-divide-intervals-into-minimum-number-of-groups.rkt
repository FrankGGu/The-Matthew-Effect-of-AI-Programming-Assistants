(define (min-groups-intervals intervals)
  (let* ((events (append-map (lambda (interval)
                                (list (list (car interval) 1)    ; Start event: (time 1)
                                      (list (cadr interval) -1))) ; End event: (time -1)
                              intervals))
         (sorted-events (sort events
                              (lambda (e1 e2)
                                (let ((time1 (car e1)) (type1 (cadr e1)))
                                  (let ((time2 (car e2)) (type2 (cadr e2)))
                                    (cond
                                      ((< time1 time2) #t)
                                      ((> time1 time2) #f)
                                      ((< type1 type2) #t) ; Process end events (-1) before start events (1) at the same time
                                      (#t #f)))))))
    (let loop ((current-overlap 0)
               (max-overlap 0)
               (remaining-events sorted-events))
      (if (null? remaining-events)
          max-overlap
          (let* ((event (car remaining-events))
                 (type (cadr event))
                 (new-current-overlap (+ current-overlap type)))
            (loop new-current-overlap
                  (max max-overlap new-current-overlap)
                  (cdr remaining-events)))))))