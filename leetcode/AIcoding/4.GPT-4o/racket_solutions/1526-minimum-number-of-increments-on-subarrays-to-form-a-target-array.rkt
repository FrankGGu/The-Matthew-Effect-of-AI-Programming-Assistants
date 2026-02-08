(define (min-increments target)
  (define (helper target)
    (if (null? target)
        0
        (let* ([n (length target)]
               [max-target (apply max target)]
               [max-increment (foldl (lambda (acc x)
                                         (+ acc (max 0 (- max-target x))))
                                       0
                                       target)])
          (if (zero? max-increment)
              0
              (+ max-increment (helper (map (lambda (x) (- x max-target)) target))))))))
  (helper target))