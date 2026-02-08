(define (min-increment-for-unique A)
  (define (helper lst)
    (if (null? lst)
        0
        (let* ((sorted (sort lst <))
               (increments (apply + (map (lambda (x) (max 0 (- (car sorted) x))) (cdr sorted)))))
          (+ increments (helper (map (lambda (x) (max (car sorted) x)) (cdr sorted)))))))
  (helper (sort A <)))