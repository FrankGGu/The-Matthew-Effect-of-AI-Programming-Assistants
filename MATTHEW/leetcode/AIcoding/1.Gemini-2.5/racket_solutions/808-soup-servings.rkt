(define (soup-servings n)
  (if (>= n 4800)
      1.0
      (let* ((scaled-n (ceiling (/ n 25.0)))
             (memo (make-hash)))
        (define (solve a b)
          (cond
            ((and (<= a 0) (<= b 0)) 0.5)
            ((<= a 0) 1.0)
            ((<= b 0) 0.0)
            (else
             (let ((key (cons a b)))
               (match (hash-ref memo key #f)
                 (#f
                  (let ((res (+ (* 0.25 (solve (- a 4) b))
                                (* 0.25 (solve (- a 3) (- b 1)))
                                (* 0.25 (solve (- a 2) (- b 2)))
                                (* 0.25 (solve (- a 1) (- b 3))))))
                    (hash-set! memo key res)
                    res))
                 (val val))))))
        (solve scaled-n scaled-n))))