(define (search-range nums target)
  (define (find-first nums target low high)
    (if (> low high)
        -1
        (let ((mid (floor (+ low high) 2)))
          (cond
            ((and (= (list-ref nums mid) target)
                  (or (= mid 0)
                      (not (= (list-ref nums (- mid 1)) target))))
             mid)
            ((>= (list-ref nums mid) target)
             (find-first nums target low (- mid 1)))
            (else
             (find-first nums target (+ mid 1) high))))))

  (define (find-last nums target low high)
    (if (> low high)
        -1
        (let ((mid (floor (+ low high) 2)))
          (cond
            ((and (= (list-ref nums mid) target)
                  (or (= mid (- (length nums) 1))
                      (not (= (list-ref nums (+ mid 1)) target))))
             mid)
            ((<= (list-ref nums mid) target)
             (find-last nums target (+ mid 1) high))
            (else
             (find-last nums target low (- mid 1)))))))

  (list (find-first nums target 0 (- (length nums) 1))
        (find-last nums target 0 (- (length nums) 1))))