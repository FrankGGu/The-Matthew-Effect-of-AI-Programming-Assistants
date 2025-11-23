(define (printInOrder)
  (define (print-1) (display 1) (newline))
  (define (print-2) (display 2) (newline))
  (define (print-3) (display 3) (newline))

  (define (print) 
    (print-1)
    (print-2)
    (print-3))

  (thread print)
  (thread print)
  (thread print))

(printInOrder)