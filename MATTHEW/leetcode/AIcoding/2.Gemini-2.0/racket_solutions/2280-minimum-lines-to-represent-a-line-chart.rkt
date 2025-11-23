(define (minimum-lines points)
  (define (slope p1 p2)
    (if (= (first p1) (first p2))
        #inf.0
        (/ (- (second p2) (second p1))
           (- (first p2) (first p1)))))

  (define (helper points current-lines last-slope)
    (cond
      [(null? points) current-lines]
      [(null? (cdr points)) current-lines]
      [else
       (let* ([p1 (first points)]
              [p2 (second points)]
              [new-slope (slope p1 p2)])
         (if (equal? new-slope last-slope)
             (helper (cdr points) current-lines last-slope)
             (helper (cdr points) (+ current-lines 1) new-slope)))]))

  (if (null? points)
      0
      (helper points 0 #f)))