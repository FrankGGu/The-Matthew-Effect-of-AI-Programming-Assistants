(define ProductOfNumbers%
  (class object%
    (init-field nums)
    (super-new)

    (define current-products (list 1))

    (define/public (add num)
      (if (= num 0)
          (set! current-products (list 1))
          (set! current-products (append current-products (list (* num (car (reverse current-products))))))))

    (define/public (getProduct k)
      (if (< k (length current-products))
          (/ (car (reverse current-products)) (car (reverse (drop current-products k))))
          0))
    ))

(define (ProductOfNumbers nums)
  (new ProductOfNumbers% [nums nums]))