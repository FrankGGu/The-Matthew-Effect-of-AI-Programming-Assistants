(define (car-pooling trips capacity)
  (let* ((max-possible-location 1001) ; Locations are between 0 and 1000, so 1001 covers indices 0-1000
         (passenger-changes (make-vector max-possible-location 0)))

    ;; Populate the passenger-changes array based on trip start and end locations
    (for-each (lambda (trip)
                (let ((num-passengers (list-ref trip 0))
                      (start-location (list-ref trip 1))
                      (end-location (list-ref trip 2)))
                  ;; Add passengers at the start location
                  (vector-set! passenger-changes start-location
                               (+ (vector-ref passenger-changes start-location) num-passengers))
                  ;; Subtract passengers at the end location (they are dropped off)
                  (vector-set! passenger-changes end-location
                               (- (vector-ref passenger-changes end-location) num-passengers))))
              trips)

    ;; Iterate through all possible locations to check capacity
    (let loop ((location 0)
               (current-passengers 0))
      (cond
        ;; If we have checked all locations without exceeding capacity, return true
        ((>= location max-possible-location)
         #t)
        (else
         ;; Update the number of passengers in the car at the current location
         (let ((new-passengers (+ current-passengers (vector-ref passenger-changes location))))
           ;; If capacity is exceeded, return false
           (if (> new-passengers capacity)
               #f
               ;; Otherwise, continue to the next location
               (loop (+ location 1) new-passengers))))))))