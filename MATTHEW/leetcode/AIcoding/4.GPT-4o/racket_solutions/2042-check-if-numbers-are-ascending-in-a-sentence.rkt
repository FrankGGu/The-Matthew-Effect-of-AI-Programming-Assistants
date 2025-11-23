(define (are-numbers-ascending s)
  (define (helper words prev)
    (if (null? words)
        #t
        (let ((num (string->number (car words))))
          (if (and num (> num prev))
              (helper (cdr words) num)
              #f))))
  (helper (filter (lambda (x) (string->number x)) (string-split s)) 0))