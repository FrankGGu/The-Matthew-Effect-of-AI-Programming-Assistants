(define (number-of-ways startPos endPos k)
  (define memo (make-hash))
  (define (solve current k)
    (cond
      [(= k 0) (if (= current endPos) 1 0)]
      [(< k 0) 0]
      [else
       (let ([key (cons current k)])
         (if (hash-has-key? memo key)
             (hash-ref memo key)
             (let ([result (modulo (+ (solve (+ current 1) (- k 1))
                                      (solve (- current 1) (- k 1)))
                                1000000007)])
               (hash-set! memo key result)
               result))))))
  (solve startPos k))