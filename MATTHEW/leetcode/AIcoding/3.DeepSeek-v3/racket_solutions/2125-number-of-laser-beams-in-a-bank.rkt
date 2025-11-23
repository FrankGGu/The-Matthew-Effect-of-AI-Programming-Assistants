(define (number-of-beams bank)
  (let loop ([prev 0] [total 0] [rows bank])
    (if (null? rows)
        total
        (let ([current (count (lambda (c) (char=? c #\1)) (string->list (car rows)))])
          (if (zero? current)
              (loop prev total (cdr rows))
              (loop current (+ total (* prev current)) (cdr rows)))))))