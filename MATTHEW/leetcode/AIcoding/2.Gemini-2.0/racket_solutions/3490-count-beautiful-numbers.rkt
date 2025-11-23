(define (count-beautiful-numbers n)
  (define (is-beautiful? num)
    (let loop ((num num) (i 1))
      (cond
        ((zero? num) #t)
        (else
         (let ((digit (remainder num 10)))
           (if (and (not (zero? digit)) (zero? (remainder i digit)))
               (loop (quotient num 10) (+ i 1))
               #f))))))

  (let loop ((i 1) (count 0))
    (cond
      ((> i n) count)
      (else
       (if (is-beautiful? i)
           (loop (+ i 1) (+ count 1))
           (loop (+ i 1) count))))))