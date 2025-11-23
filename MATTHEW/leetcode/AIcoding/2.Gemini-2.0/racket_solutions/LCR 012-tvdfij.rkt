(define (pivot-index nums)
  (define total-sum (apply + nums))
  (define (helper nums left-sum index)
    (cond [(empty? nums) -1]
          [(= left-sum (- total-sum left-sum (car nums))) index]
          [else (helper (cdr nums) (+ left-sum (car nums)) (+ 1 index))]))
  (helper nums 0 0))