(define (get-row rowIndex)
  (cond
    [(zero? rowIndex) '(1)]
    [else
     (let loop ([i 1] [row '(1)])
       (if (> i rowIndex)
           row
           (loop (+ i 1) (next-row row))))]))

(define (next-row row)
  (cons 1 (map + row (cdr row))))