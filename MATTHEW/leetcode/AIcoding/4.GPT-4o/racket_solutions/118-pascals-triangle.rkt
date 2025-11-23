(define (generate numRows)
  (define (helper n)
    (if (zero? n)
        (list (list 1))
        (let ((prev (helper (- n 1))))
          (define current (cons 1 
                                (map + (car prev) (append (cdr (car prev)) (list 0)))))
          (cons current prev))))
  (reverse (helper numRows)))