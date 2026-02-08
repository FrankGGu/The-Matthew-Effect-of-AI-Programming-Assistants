(define (min-length s)
  (define (reduce str)
    (let loop ((s str) (res '()))
      (cond
        [(null? s) (list->string (reverse res))]
        [(and (>= (string-length s) 2)
              (equal? (string-ref s 0) (string-ref s 1)))
         (loop (substring s 2) res)]
        [else (loop (cdr s) (cons (car s) res))])))
  (let loop ((current s))
    (let ((next (reduce current)))
      (if (equal? next current)
          (string-length next)
          (loop next)))))

(define (minimum_length_after_operations s)
  (min-length s))