(define (max-strength nums)
  (define (helper lst current-max current-min)
    (if (null? lst)
        current-max
        (let* ((num (car lst))
          (if (null? (cdr lst))
              (max current-max (* current-max num) (* current-min num) num)
              (let ((new-max (max (* current-max num) (* current-min num) num current-max))
                    (new-min (min (* current-max num) (* current-min num) num current-min)))
                (helper (cdr lst) new-max new-min))))))
  (if (null? nums)
      0
      (helper nums (car nums) (car nums))))