(define (remove-covered-intervals intervals)
  (define (covered? i j)
    (and (<= (car i) (car j))
         (>= (cadr i) (cadr j))))

  (define (count-uncovered intervals)
    (let loop ([intervals intervals] [uncovered 0])
      (cond
        [(null? intervals) uncovered]
        [else
         (let* ([current (car intervals)]
                [rest (cdr intervals)]
                [is-covered? (ormap (lambda (other) (and (not (equal? current other)) (covered? current other))) rest)])
           (if is-covered?
               (loop rest uncovered)
               (loop rest (+ uncovered 1))))])))

  (count-uncovered (sort intervals (lambda (i j) (or (< (car i) (car j)) (and (= (car i) (car j)) (> (cadr i) (cadr j))))))))