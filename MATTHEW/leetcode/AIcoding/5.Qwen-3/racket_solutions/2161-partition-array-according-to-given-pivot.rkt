(define (partition-array nums pivot)
  (let loop ([nums nums] [less '()] [equal '()] [greater '()])
    (cond
      [(null? nums) (append less equal greater)]
      [(< (car nums) pivot) (loop (cdr nums) (cons (car nums) less) equal greater)]
      [(= (car nums) pivot) (loop (cdr nums) less (cons (car nums) equal) greater)]
      [else (loop (cdr nums) less equal (cons (car nums) greater))])))