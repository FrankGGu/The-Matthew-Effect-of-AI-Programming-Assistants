(define (findMaxForm strs m n)
  (define (count-zeros-ones str)
    (let loop ((s (string->list str)) (zeroes 0) (ones 0))
      (cond
        [(null? s) (list zeroes ones)]
        [(equal? (car s) #\0) (loop (cdr s) (+ zeroes 1) ones)]
        [(equal? (car s) #\1) (loop (cdr s) zeroes (+ ones 1))])))

  (define (dp i m n)
    (if (or (= i (length strs)) (<= m 0) (<= n 0))
        0
        (let* ((count (count-zeros-ones (list-ref strs i)))
               (zeroes (car count))
               (ones (cadr count)))
          (if (and (<= zeroes m) (<= ones n))
              (max (dp (+ i 1) m n)
                   (+ 1 (dp (+ i 1) (- m zeroes) (- n ones))))
              (dp (+ i 1) m n)))))

  (dp 0 m n))