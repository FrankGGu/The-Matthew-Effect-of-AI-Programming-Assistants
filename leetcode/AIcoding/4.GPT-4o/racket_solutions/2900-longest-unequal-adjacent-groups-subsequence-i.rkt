(define (longest-unequal-adjacent-groups seq)
  (define (helper seq prev count)
    (if (null? seq)
        count
        (let ((current (car seq)))
          (if (equal? current prev)
              (helper (cdr seq) prev count)
              (helper (cdr seq) current (+ count 1))))))
  (helper seq '() 0))

(longest-unequal-adjacent-groups '(1 1 2 3 2 2 3 1 1))