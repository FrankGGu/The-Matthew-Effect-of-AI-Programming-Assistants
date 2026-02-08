(define (max-product nums)
  (define (helper nums max-so-far min-so-far result)
    (if (null? nums)
        result
        (let* ((current (car nums))
               (temp-max (* max-so-far current))
               (temp-min (* min-so-far current))
               (max-so-far (max current temp-max temp-min))
               (min-so-far (min current temp-max temp-min)))
          (helper (cdr nums) max-so-far min-so-far (max result max-so-far)))))
  (helper nums 1 1 (car nums)))

(max-product (vector->list (vector 2, 3, -2, 4)))