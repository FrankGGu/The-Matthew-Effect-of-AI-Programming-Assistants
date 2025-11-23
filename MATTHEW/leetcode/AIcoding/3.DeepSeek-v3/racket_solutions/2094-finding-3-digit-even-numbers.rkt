(define (find-even-numbers digits)
  (define (valid? num)
    (and (>= num 100) (<= num 999) (even? num)))

  (define (permute lst n)
    (cond
      [(= n 0) '(())]
      [else
       (for*/list ([x lst]
                   [xs (permute (remove x lst 1) (- n 1))])
         (cons x xs))]))

  (define candidates
    (for*/list ([p (permute digits 3)]
                [num (list (string->number (apply string (map number->string p))))]
      num))

  (sort (remove-duplicates (filter valid? candidates)) <))