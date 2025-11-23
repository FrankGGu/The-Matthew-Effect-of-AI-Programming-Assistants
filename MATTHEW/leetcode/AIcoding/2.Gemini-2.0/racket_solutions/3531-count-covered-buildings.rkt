(define (count-covered-buildings intervals)
  (define events (make-vector (* 2 (length intervals)) '()))
  (for ([i (in-range (length intervals))])
    (let ([interval (list-ref intervals i)])
      (vector-set! events (* 2 i) (list (car interval) 1))
      (vector-set! events (+ 1 (* 2 i)) (list (cadr interval) -1))))
  (define sorted-events (sort (vector->list events) (lambda (a b) (if (= (car a) (car b)) (> (cadr a) (cadr b)) (< (car a) (car b))))))
  (define (helper events current-count covered-length prev-pos)
    (cond
      [(empty? events) covered-length]
      [else
       (let* ([event (car events)]
              [pos (car event)]
              [type (cadr event)])
         (let ([new-covered-length (+ covered-length (* (if (> current-count 0) 1 0) (- pos prev-pos)))]
               [new-current-count (+ current-count type)])
           (helper (cdr events) new-current-count new-covered-length pos))))])
  (helper sorted-events 0 0 0))