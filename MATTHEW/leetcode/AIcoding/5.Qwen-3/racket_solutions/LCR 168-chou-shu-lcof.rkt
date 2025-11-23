(define (nth-ugly-number n)
  (define (helper i nums)
    (if (= i n)
        (car nums)
        (let* ([next (* (car nums) 2)]
               [next2 (* (car nums) 3)]
               [next3 (* (car nums) 5)]
               [min-next (apply min (list next next2 next3))])
          (helper (+ i 1) (cons min-next (cdr nums))))))
  (helper 1 '(1)))