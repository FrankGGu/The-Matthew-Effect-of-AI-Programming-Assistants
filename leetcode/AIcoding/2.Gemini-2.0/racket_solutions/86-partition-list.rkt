(define (partition lst x)
  (let loop ([lst lst] [less '()] [greater-equal '()])
    (cond
      [(null? lst) (append (reverse less) greater-equal)]
      [(< (car lst) x) (loop (cdr lst) (cons (car lst) less) greater-equal)]
      [else (loop (cdr lst) less (cons (car lst) greater-equal))])))