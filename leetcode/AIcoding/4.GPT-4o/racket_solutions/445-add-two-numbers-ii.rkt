(define (addTwoNumbers l1 l2)
  (define (reverse-list lst)
    (if (null? lst)
        '()
        (cons (car (reverse-list (cdr lst))) (list (car lst)))))

  (define l1-rev (reverse-list l1))
  (define l2-rev (reverse-list l2))

  (define (add-helper l1 l2 carry)
    (cond
      ((and (null? l1) (null? l2) (= carry 0)) '())
      (else
        (let* ((val1 (if (null? l1) 0 (car l1)))
               (val2 (if (null? l2) 0 (car l2)))
               (sum (+ val1 val2 carry))
               (new-carry (if (>= sum 10) 1 0))
               (digit (modulo sum 10)))
          (cons digit (add-helper (if (null? l1) '() (cdr l1))
                                   (if (null? l2) '() (cdr l2))
                                   new-carry))))))

  (define result (add-helper l1-rev l2-rev 0))

  (reverse-list result))