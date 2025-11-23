(define (rob nums)
  (define (helper nums)
    (if (null? nums)
        0
        (max (car nums) (+ (cadr nums) (helper (cddr nums))))))
  (if (<= (length nums) 2)
      (apply max nums)
      (max (helper (cdr nums)) (helper (butlast nums)))))

(define (houseRobberIV nums k)
  (if (null? nums)
      0
      (if (<= k 0)
          (rob nums)
          (let ([n (length nums)])
            (if (<= n k)
                (apply + nums)
                (rob (take (append (drop nums k) (take nums k)) n))))))))

(define (main)
  (houseRobberIV (vector->list (list 2 3 2)) 3))

(main)