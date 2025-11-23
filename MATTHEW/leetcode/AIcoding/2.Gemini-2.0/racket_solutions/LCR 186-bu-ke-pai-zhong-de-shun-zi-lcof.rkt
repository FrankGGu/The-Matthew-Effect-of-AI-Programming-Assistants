(define (check-dynasty date dynasty-list)
  (cond
    [(null? dynasty-list) #f]
    [(<= (car (car dynasty-list)) date (cdr (car dynasty-list))) #t]
    [else (check-dynasty date (cdr dynasty-list))]))

(define (solve date dynasty-list)
  (if (check-dynasty date dynasty-list)
      "Yes"
      "No"))