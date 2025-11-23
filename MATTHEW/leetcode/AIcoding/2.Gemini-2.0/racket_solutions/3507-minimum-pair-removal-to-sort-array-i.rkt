(define (min-deletion nums)
  (let loop ([nums nums] [count 0])
    (cond
      [(empty? nums) count]
      [(empty? (cdr nums)) count]
      [(<= (car nums) (cadr nums)) (loop (cdr nums) count)]
      [else (loop (cddr nums) (+ count 1))])))