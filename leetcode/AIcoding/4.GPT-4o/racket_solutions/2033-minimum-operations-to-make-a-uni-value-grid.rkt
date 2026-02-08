(define (minOperations grid x)
  (define flat-grid (apply append grid))
  (define mod-x (map (lambda (num) (mod num x)) flat-grid))
  (if (not (equal? (apply car mod-x) (apply cdr mod-x)))
      -1
      (let ((sorted (sort flat-grid <)))
        (define med (list-ref sorted (floor (/ (length sorted) 2))))
        (apply + (map (lambda (num) (abs (- num med))) flat-grid)))))

(define (minOperations grid x)
  (minOperations grid x))