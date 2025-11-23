(define (ways n x)
  (define (power a b)
    (if (= b 0)
        1
        (* a (power a (- b 1)))))

  (define (helper current-sum current-num)
    (cond
      ((= current-sum n) 1)
      ((> current-sum n) 0)
      ((> (power current-num x) (- n current-sum)) 0)
      (else (+ (helper current-sum (+ current-num 1))
               (helper (+ current-sum (power current-num x)) (+ current-num 1))))))

  (helper 0 1))