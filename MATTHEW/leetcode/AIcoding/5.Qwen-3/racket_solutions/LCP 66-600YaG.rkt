(define (min-halls rooms)
  (define (compare a b)
    (< (car a) (car b)))
  (define sorted-rooms (sort rooms compare))
  (define (helper rooms halls)
    (cond [(null? rooms) (length halls)]
          [else
           (let ([current (car rooms)])
             (let ([start (car current)]
                   [end (cadr current)])
               (let ([new-halls (filter (lambda (h) (>= (car h) end)) halls)])
                 (if (null? new-halls)
                     (helper (cdr rooms) (append halls (list (list start end))))
                     (helper (cdr rooms) (cons (list start end) (cdr new-halls)))))))]))
  (helper sorted-rooms '()))