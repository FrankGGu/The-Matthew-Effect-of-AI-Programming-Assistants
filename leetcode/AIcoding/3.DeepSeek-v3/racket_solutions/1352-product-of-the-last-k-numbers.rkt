(define product-of-numbers%
  (class object%
    (super-new)
    (init-field)
    (define nums '(1))

    (define/public (add num)
      (if (zero? num)
          (set! nums '(1))
          (set! nums (cons (* num (car nums)) nums))))

    (define/public (get-product k)
      (if (>= k (length nums))
          0
          (/ (car nums) (list-ref nums k))))))