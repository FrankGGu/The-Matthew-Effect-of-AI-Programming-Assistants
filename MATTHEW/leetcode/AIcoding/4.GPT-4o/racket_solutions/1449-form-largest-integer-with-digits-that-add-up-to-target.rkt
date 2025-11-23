(define (largestInteger target digits)
  (define (helper target digits)
    (if (zero? target) (list '())
        (let loop ((max '()) (remaining digits))
          (cond
            ((null? remaining) max)
            (else
             (for-each (lambda (d)
                         (when (<= d target)
                           (let ((new-max (cons d max)))
                             (loop new-max (remove d remaining)))))
                       remaining))))))

  (let ((result (helper target (sort digits >))))
    (if (null? result) "0" (apply string-append (map number->string result)))))