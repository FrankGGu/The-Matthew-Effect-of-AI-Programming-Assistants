(define (matrix-reshape nums r c)
  (let* ((flat (apply append nums))
         (len (length flat)))
    (if (or (> (* r c) len) (< (* r c) len))
        nums
        (let loop ((lst flat) (res '()) (count 0))
          (cond ((null? lst) (reverse res))
                ((= count c) (loop lst (cons '() res) 0))
                (else (loop (cdr lst) (cons (car lst) (car res)) (+ count 1))))))))