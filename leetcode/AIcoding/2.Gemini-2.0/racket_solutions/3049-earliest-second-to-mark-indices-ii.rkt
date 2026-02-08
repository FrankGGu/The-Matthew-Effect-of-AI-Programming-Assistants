(define (earliest-second-to-mark-indices max-changes nums change-indices)
  (define (check t)
    (let loop ((i 0) (changes max-changes) (marked (make-vector (length nums) #f)))
      (cond
        ((= i t) (andmap values marked))
        (else
         (let ((idx (- (list-ref change-indices i) 1)))
           (if (not (vector-ref marked idx))
               (cond
                 ((> (list-ref nums idx) 0)
                  (let ((dec (min changes (list-ref nums idx))))
                    (loop (+ i 1) (- changes dec) marked)))
                 (else
                  (vector-set! marked idx #t)
                  (loop (+ i 1) changes marked)))
               (loop (+ i 1) changes marked)))))))

  (define (binary-search low high)
    (cond
      ((> low high) -1)
      (else
       (let ((mid (floor (+ low high) 2)))
         (if (check mid)
             (let ((prev (binary-search low (- mid 1))))
               (if (= prev -1) mid prev))
             (binary-search (+ mid 1) high))))))

  (binary-search 1 (length change-indices)))