(define (minimum-cost nums cost)
  (define (calculate-cost target)
    (foldl + 0 (map (lambda (x c) (* (abs (- x target)) c)) nums cost)))

  (define (find-median nums cost)
    (define (weighted-median nums cost total-weight)
      (define (helper nums cost current-weight)
        (cond
          [(null? nums) (error "Empty list")]
          [(>= current-weight (/ total-weight 2)) (car nums)]
          [else (helper (cdr nums) (cdr cost) (+ current-weight (cadr cost)))]))
      (let* ((sorted-data (sort (map list nums cost) < #:key car)))
        (helper (map car sorted-data) (map cadr sorted-data) 0))))

    (weighted-median nums cost (foldl + 0 cost)))

  (let ((median (find-median nums cost)))
    (calculate-cost median)))