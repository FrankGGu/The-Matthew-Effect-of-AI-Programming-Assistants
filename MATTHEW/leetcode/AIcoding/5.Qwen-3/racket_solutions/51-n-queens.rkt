#lang racket

(define (solve-n-queens n)
  (define (is-safe? board row col)
    (let loop ([r 0])
      (cond [(= r row) #t]
            [(and (= (list-ref board r) col) #t) #f]
            [(= (abs (- row r)) (abs (- col (list-ref board r)))) #f]
            [else (loop (+ r 1))])))

  (define (backtrack board result row)
    (if (= row n)
        (set! result (cons (map (lambda (x) (string-append (make-string x #\.) "Q" (make-string (- n x 1) #\.))) board) result))
        (for-each (lambda (col)
                    (when (is-safe? board row col)
                      (backtrack (append board (list col)) result (+ row 1))))
                  (range n))))

  (define result '())
  (backtrack '() result 0)
  result)