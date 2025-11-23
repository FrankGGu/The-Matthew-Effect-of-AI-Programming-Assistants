(define (max-product-subarray nums)
  (define (helper nums max-so-far min-so-far result)
    (if (null? nums)
        result
        (let* ((num (car nums))
               (new-max (max (* max-so-far num) (* min-so-far num) num))
               (new-min (min (* max-so-far num) (* min-so-far num) num)))
          (helper (cdr nums) new-max new-min (max result new-max)))))
  (if (null? nums)
      0
      (helper nums (car nums) (car nums) (car nums))))