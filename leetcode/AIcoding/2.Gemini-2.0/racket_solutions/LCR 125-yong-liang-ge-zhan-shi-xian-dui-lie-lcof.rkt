(define (sort-the-books books)
  (define (insert book sorted)
    (cond
      [(empty? sorted) (list book)]
      [(<= (car book) (caar sorted)) (cons book sorted)]
      [else (cons (car sorted) (insert book (cdr sorted)))]))
  (define (helper books sorted)
    (cond
      [(empty? books) sorted]
      [else (helper (cdr books) (insert (car books) sorted))]))
  (helper books '()))