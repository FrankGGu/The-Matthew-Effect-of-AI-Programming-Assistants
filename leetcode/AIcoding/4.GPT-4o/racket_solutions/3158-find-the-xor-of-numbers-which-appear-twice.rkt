(define (xor-of-numbers-appearing-twice nums)
  (define (xor-helper lst result)
    (if (null? lst)
        result
        (xor-helper (cdr lst) (if (member (car lst) (cdr lst)) (bitwise-xor result (car lst)) result))))
  (xor-helper nums 0))

(xor-of-numbers-appearing-twice '(4 3 2 7 8 2 3 1))