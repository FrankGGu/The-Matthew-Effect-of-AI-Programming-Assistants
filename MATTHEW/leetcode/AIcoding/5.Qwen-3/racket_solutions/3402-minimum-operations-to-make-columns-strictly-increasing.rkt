(define (min-operations-to-make-columns-strictly-increasing matrix)
  (define (helper prev row)
    (if (null? row)
        0
        (+ (if (< (car row) prev) 0 1)
           (helper (if (< (car row) prev) prev (car row)) (cdr row)))))
  (apply + (map (lambda (col) (helper -inf.0 col)) (apply map list matrix))))