(define (max-width-of-vertical-area points)
  (define sorted-x (sort (map (lambda (p) (car p)) points) <))
  (define (max-diff lst)
    (if (null? (cdr lst))
        0
        (max (- (cadr lst) (car lst)) (max-diff (cdr lst)))))
  (max-diff sorted-x))