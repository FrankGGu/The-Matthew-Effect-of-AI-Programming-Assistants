(define (maxSalesDays sales)
  (define (count-max-days lst)
    (if (null? lst)
        0
        (if (= (car lst) (car (cdr lst)))
            (+ 1 (count-max-days (cdr lst)))
            0)))
  (define (helper lst max-count)
    (if (null? lst)
        max-count
        (let ((count (count-max-days lst)))
          (helper (cdr lst) (max max-count count)))))
  (helper sales 0))

(maxSalesDays '(1 1 2 2 2 3 3 1))