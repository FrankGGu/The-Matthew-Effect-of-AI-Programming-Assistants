(define (smallest-divisible-digit-product n)
  (define (digits n)
    (if (= n 0)
        '()
        (cons (modulo n 10) (digits (quotient n 10)))))

  (define (product-of-digits lst)
    (foldl * 1 lst))

  (define (helper n d)
    (if (= d 1)
        (if (= (modulo n 1) 0) 1 0)
        (if (= (modulo n d) 0)
            (let ((next (helper (quotient n d) (- d 1))))
              (if (> next 0) 
                  (* d next) 
                  0))
            (helper n (- d 1)))))

  (define result (helper n 9))
  (if (= result 0) -1 result))

(smallest-divisible-digit-product 100)