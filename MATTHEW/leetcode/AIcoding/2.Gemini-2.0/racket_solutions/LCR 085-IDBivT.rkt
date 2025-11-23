(define (generate-parenthesis n)
  (define (generate-helper open close current acc)
    (cond
      [(and (= open 0) (= close 0)) (cons current acc)]
      [(> open close) acc]
      [(< open 0) acc]
      [else
       (let* ((acc1 (if (> open 0) (generate-helper (- open 1) close (string-append current "(") acc) acc))
              (acc2 (if (> close 0) (generate-helper open (- close 1) (string-append current ")") acc1) acc1)))
         acc2)]))
  (generate-helper n n "" '()))