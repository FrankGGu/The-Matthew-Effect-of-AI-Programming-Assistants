(define (get-accuracy a)
  (if (= (remainder a 10) 0)
      0
      (- 10 (remainder a 10))))

(define (get-account-balance balance purchases)
  (let loop ((balance balance) (purchases purchases))
    (if (null? purchases)
        balance
        (let* ((purchase (car purchases))
               (rounding (get-accuracy purchase)))
          (loop (- balance (+ purchase rounding)) (cdr purchases))))))