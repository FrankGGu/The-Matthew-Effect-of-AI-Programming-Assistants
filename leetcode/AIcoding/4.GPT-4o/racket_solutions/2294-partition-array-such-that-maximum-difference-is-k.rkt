(define (partition k nums)
  (define (loop nums acc)
    (cond
      ((null? nums) (if (null? acc) 0 (1+ (length acc))))
      ((null? acc) (loop (cdr nums) (list (car nums))))
      ((<= (abs (- (car nums) (car acc))) k) (loop (cdr nums) (cons (car nums) acc)))
      (else (loop (cdr nums) (list (car nums))))))
  (loop (sort nums <) '()))

(define (max-partition k nums)
  (partition k nums))