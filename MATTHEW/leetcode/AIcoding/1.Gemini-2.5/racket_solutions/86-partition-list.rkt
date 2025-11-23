(define (partition head x)
  (let loop ((current head)
             (less-than-x '())
             (greater-equal-x '()))
    (cond
      ((null? current)
       (append (reverse less-than-x) (reverse greater-equal-x)))
      ((< (car current) x)
       (loop (cdr current) (cons (car current) less-than-x) greater-equal-x))
      (else
       (loop (cdr current) less-than-x (cons (car current) greater-equal-x))))))