(define (largestTimeFromDigits A)
  (let* ([perms (permutations A)]
         [valid-times
          (filter (lambda (perm)
                    (let ([hour (+ (* (list-ref perm 0) 10) (list-ref perm 1))]
                          [minute (+ (* (list-ref perm 2) 10) (list-ref perm 3))])
                      (and (<= 0 hour 23) (<= 0 minute 59))))
                  perms)]
         [max-time
          (if (null? valid-times)
              #f
              (apply max (map (lambda (perm)
                                 (let ([hour (+ (* (list-ref perm 0) 10) (list-ref perm 1))]
                                       [minute (+ (* (list-ref perm 2) 10) (list-ref perm 3))])
                                   (+ (* hour 60) minute)))
                               valid-times)))])
    (if max-time
        (let ([hour (quotient max-time 60)]
              [minute (remainder max-time 60)])
          (format "~a~a:~a~a" (quotient hour 10) (remainder hour 10) (quotient minute 10) (remainder minute 10)))
        "")))

(define (permutations lst)
  (if (null? lst)
      '(())
      (foldr (lambda (x acc)
                (append (map (lambda (p) (cons x p))
                            (permutations (remove x lst 1))))
                acc)
             '()
             lst)))