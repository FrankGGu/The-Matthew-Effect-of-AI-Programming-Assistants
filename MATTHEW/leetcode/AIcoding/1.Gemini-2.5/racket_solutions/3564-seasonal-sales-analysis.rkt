#lang racket

(define (seasonal-sales-analysis sales)
  (define (get-season month-num)
    (cond
      [(<= 1 month-num 3) "Q1"]
      [(<= 4 month-num 6) "Q2"]
      [(<= 7 month-num 9) "Q3"]
      [(<= 10 month-num 12) "Q4"]
      [else "Invalid Month"]))

  (define sales-by-season (make-hash))

  (for-each
   (lambda (sale)
     (define date-str (car sale))
     (define amount (cadr sale))

     (define month-str (substring date-str 5 7))
     (define month-num (string->number month-str))

     (define season (get-season month-num))

     (hash-update! sales-by-season season (lambda (current-total) (+ current-total amount)) 0))
   sales)

  (map (lambda (pair) (list (car pair) (cdr pair))) (hash->list sales-by-season)))