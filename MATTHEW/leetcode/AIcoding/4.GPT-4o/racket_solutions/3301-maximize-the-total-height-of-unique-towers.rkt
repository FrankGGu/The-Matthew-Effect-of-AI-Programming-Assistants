(define (maxHeight A)
  (define (helper towers)
    (if (null? towers)
        0
        (let* ((h (car towers))
               (new-towers (filter (lambda (x) (< x h)) (cdr towers))))
          (+ h (helper new-towers)))))
  (helper (sort A <)))