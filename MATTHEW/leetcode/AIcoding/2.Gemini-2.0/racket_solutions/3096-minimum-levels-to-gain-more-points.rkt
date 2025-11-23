(define (minimumLevels points lose)
  (define (helper level)
    (cond
      [(null? points) 0]
      [(>= level (car points)) (+ 1 (helper level (cdr points)))]
      [else (+ 1 (helper (+ level (car lose)) points))]))
  (helper 1 points))