(define (is-special-array nums)
  (let loop ((current-list nums))
    (cond
      ((or (empty? current-list) (empty? (cdr current-list)))
       #t)
      (else
       (let ((first-val (car current-list))
             (second-val (cadr current-list)))
         (if (= (modulo first-val 2) (modulo second-val 2))
             #f
             (loop (cdr current-list))))))))