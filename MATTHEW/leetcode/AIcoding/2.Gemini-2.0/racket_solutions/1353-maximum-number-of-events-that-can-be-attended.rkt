(define (max-events events)
  (define sorted-events (sort events < #:key car))
  (define current-day 0)
  (define attended 0)
  (define pq (make-heap < #:key cdr))
  (define (helper events-list)
    (cond
      [(null? events-list)
       (cond
         [(heap-empty? pq) attended]
         [else
          (heap-remove-min! pq)
          (set! attended (+ attended 1))
          (helper events-list)])]
      [else
       (let* ((event (car events-list))
              (start-day (car event))
              (end-day (cdr event)))
         (set! current-day (max current-day start-day))
         (define (add-events events-to-add)
           (cond
             [(null? events-to-add) #t]
             [else
              (let ((next-event (car events-to-add)))
                (when (<= (car next-event) current-day)
                  (heap-add! pq next-event))
                (add-events (cdr events-to-add)))])
           #t)
         (add-events (takef events-list (lambda (e) (<= (car e) current-day))))
         (set! events-list (dropf events-list (lambda (e) (<= (car e) current-day))))
         (cond
           [(heap-empty? pq)
            (set! current-day (car (car events-list)))
            (helper events-list)]
           [else
            (let ((best-event (heap-remove-min! pq)))
              (when (<= current-day (cdr best-event))
                (set! attended (+ attended 1))
                (set! current-day (+ current-day 1)))
              (helper events-list))])])]))
  (helper sorted-events))