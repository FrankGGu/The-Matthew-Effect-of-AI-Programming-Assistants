(define (minimize-max-pair-sum nums)
  (define (helper lst)
    (if (null? lst)
        0
        (let ((a (car lst))
              (b (cadr lst)))
          (max (+ a b) (helper (cddr lst))))))
  (helper (sort nums >)))