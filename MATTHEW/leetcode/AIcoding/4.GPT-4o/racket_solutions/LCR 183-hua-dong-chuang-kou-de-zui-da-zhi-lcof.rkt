(define (largestAltitude gain)
  (let loop ((g gain) (max-alt 0) (current-alt 0))
    (cond
      ((null? g) max-alt)
      (else (loop (cdr g) (max max-alt current-alt) (+ current-alt (car g)))))))

(largestAltitude '(1 -1 0 0 -1 1 1))