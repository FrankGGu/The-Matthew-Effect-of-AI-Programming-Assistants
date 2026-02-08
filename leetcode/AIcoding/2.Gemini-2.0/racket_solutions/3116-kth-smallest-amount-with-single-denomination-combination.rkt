(define (kth-smallest amounts k)
  (define (generate-amounts current-amounts remaining-amounts)
    (if (null? remaining-amounts)
        current-amounts
        (let ((amount (car remaining-amounts))
              (rest (cdr remaining-amounts)))
          (generate-amounts (append current-amounts (map (lambda (x) (+ x amount)) current-amounts)) rest))))

  (let ((all-amounts (generate-amounts '(0) amounts)))
    (list-ref (sort (remove-duplicates all-amounts) <) k)))