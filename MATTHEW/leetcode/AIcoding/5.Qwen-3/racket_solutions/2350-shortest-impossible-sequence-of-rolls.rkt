#lang racket

(define (shortest-unique-prefix rolls)
  (define (helper rolls prefix count)
    (if (null? rolls)
        (if (= count 0) 0 (add1 count))
        (let ([current (car rolls)])
          (if (member current prefix)
              (helper (cdr rolls) prefix count)
              (helper (cdr rolls) (append prefix (list current)) (add1 count))))))
  (helper rolls '() 0))

(define (solve)
  (let ([input (read-line)])
    (if (eof-object? input)
        (void)
        (begin
          (display (shortest-unique-prefix (map string->number (string-split input))))
          (newline)
          (solve)))))

(solve)