(define (max-ascending-sum nums)
  (define (helper lst acc max-sum)
    (cond
      ((null? lst) max-sum)
      ((or (null? (cdr lst)) (> (car lst) (cadr lst)))
       (helper (cdr lst) (+ acc (car lst)) (max max-sum (+ acc (car lst)))))
      (else
       (helper (cdr lst) (+ acc (car lst)) max-sum))))
  (helper nums 0 0))