(define (tallest-billboard rods)
  (let ((sum (apply + rods)))
    (letrec ((dp (make-hash #f)))
      (let ((helper
             (lambda (i diff)
               (cond
                 ((= i (length rods))
                  (if (= diff 0) 0 -inf.0))
                 ((hash-has-key? dp (cons i diff))
                  (hash-ref dp (cons i diff)))
                 (else
                  (let ((res (max (helper (+ i 1) diff)
                                  (+ (list-ref rods i) (helper (+ i 1) (+ diff (list-ref rods i))))
                                  (helper (+ i 1) (- diff (list-ref rods i))))))
                    (hash-set! dp (cons i diff) res)
                    res))))))
        (helper 0 0)))))