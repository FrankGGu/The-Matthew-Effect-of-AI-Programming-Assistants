(define (minimum-time first-room-delay)
  (let ((n (length first-room-delay)))
    (let loop ((time 0) (curr-room 0))
      (cond
        [(>= curr-room n) time]
        [else
         (let ((delay (list-ref first-room-delay curr-room)))
           (let ((next-time (max time delay)))
             (loop (add1 next-time) (add1 curr-room)))))))))