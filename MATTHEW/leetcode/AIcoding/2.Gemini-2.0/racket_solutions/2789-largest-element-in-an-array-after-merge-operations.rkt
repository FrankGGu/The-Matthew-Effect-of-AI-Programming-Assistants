(define (largest-element nums)
  (let loop ((nums nums) (acc '()))
    (cond
      [(null? nums)
       (if (null? acc)
           0
           (apply max acc))]
      [(null? (cdr nums))
       (if (null? acc)
           (car nums)
           (apply max (cons (car nums) acc)))]
      [else
       (let ((first (car nums))
             (second (cadr nums)))
         (if (<= first second)
             (loop (cons (+ first second) (cddr nums)) acc)
             (loop (cdr nums) (cons first acc))))])))