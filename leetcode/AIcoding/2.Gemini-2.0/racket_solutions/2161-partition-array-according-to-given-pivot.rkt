(define (pivot-array nums pivot)
  (let loop ([less '()] [equal '()] [greater '()] [nums nums])
    (cond
      [(empty? nums)
       (append (reverse less) equal (reverse greater))]
      [(< (car nums) pivot)
       (loop (cons (car nums) less) equal greater (cdr nums))]
      [(equal? (car nums) pivot)
       (loop less (append equal (list (car nums))) greater (cdr nums))]
      [else
       (loop less equal (cons (car nums) greater) (cdr nums))])))