(define (dynamic-password n k)
  (define (helper current-n current-k)
    (if (= current-k 0)
        (list current-n)
        (apply append
               (map (lambda (digit)
                      (helper (+ current-n (* 10 digit)) (- current-k 1)))
                    (range 10)))))
  (map number->string (helper 0 k)))

(dynamic-password 0 3)