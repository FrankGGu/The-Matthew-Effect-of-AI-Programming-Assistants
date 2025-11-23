(define (exam-room n)
  (struct exam-room-state (n heap) #:mutable)

  (define (make-state n)
    (exam-room-state n (make-heap <)))

  (define (add-interval state x y)
    (heap-add! (exam-room-state-heap state) (cons x y)))

  (define (find-max-interval state)
    (let loop ((h (exam-room-state-heap state)))
      (if (heap-empty? h)
          #f
          (let ((interval (heap-remove-min! h)))
            (if (or (null? interval) (not (cons? interval)))
                (loop h)
                (let ((x (car interval)) (y (cdr interval)))
                  (if (or (<= y x) (> y (exam-room-state-n state)) (< x 0))
                      (loop h)
                      interval)))))))

  (define (calculate-dist x y)
    (cond
      ((= x -1) y)
      ((= y (exam-room-state-n state)) (- y x))
      (else (quotient (- y x) 2))))

  (define (seat state)
    (let ((max-interval (find-max-interval state)))
      (if (not max-interval)
          (begin
            (add-interval state -1 0)
            0)
          (let ((x (car max-interval)) (y (cdr max-interval)))
            (let ((dist (calculate-dist x y)))
              (cond
                ((= x -1)
                 (add-interval state -1 y)
                 0)
                ((= y (exam-room-state-n state))
                 (add-interval state x y)
                 (- y 1))
                (else
                 (let ((pos (+ x dist)))
                   (add-interval state x pos)
                   (add-interval state pos y)
                   pos))))))))

  (define (leave state p)
    (let loop ((h (exam-room-state-heap state)) (intervals '()))
      (if (heap-empty? h)
          (let ((new-h (make-heap <)))
            (for-each (lambda (i) (heap-add! new-h i)) intervals)
            (set-exam-room-state-heap! state new-h))
          (let ((interval (heap-remove-min! h)))
            (if (or (null? interval) (not (cons? interval)))
                (loop h intervals)
                (let ((x (car interval)) (y (cdr interval)))
                  (cond
                    ((and (= x -1) (= y p))
                     (loop h intervals))
                    ((and (= x p) (= y (exam-room-state-n state)))
                     (loop h intervals))
                    ((and (> x -1) (< y (exam-room-state-n state)) (= (+ x (calculate-dist x y)) p))
                     (loop h (cons (cons x y) intervals)))
                    ((and (> x -1) (< y (exam-room-state-n state)) (= (+ y (- y x)) p))
                     (loop h (cons (cons x y) intervals)))
                    (else (loop h (cons interval intervals))))))))))

  (define (make-exam-room n)
    (let ((state (make-state n)))
      (define (obj m)
        (case m
          ((seat) (seat state))
          ((leave) (lambda (p) (leave state p)))
          (else (error "Invalid method" m))))
      obj))

  make-exam-room)