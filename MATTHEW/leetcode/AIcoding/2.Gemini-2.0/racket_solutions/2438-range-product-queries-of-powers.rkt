(define (range-product-queries-of-powers n queries)
  (define powers (list))
  (let loop ([i 0] [num n])
    (if (= num 0)
        (reverse powers)
        (if (odd? num)
            (begin
              (set! powers (cons i powers))
              (loop (+ i 1) (quotient num 2)))
            (loop (+ i 1) (quotient num 2)))))

  (map
   (lambda (query)
     (let loop ([i (car query)] [j (cadr query)] [prod 1])
       (if (> i j)
           prod
           (loop (+ i 1) j (modulo (* prod (expt 2 (list-ref powers i))) 1000000007))))
     )
   queries))