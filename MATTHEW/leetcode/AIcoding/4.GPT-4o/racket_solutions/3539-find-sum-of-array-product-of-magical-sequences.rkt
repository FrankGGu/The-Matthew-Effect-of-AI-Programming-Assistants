(define (magical-sequences arr)
  (define (helper lst)
    (if (null? lst)
        1
        (* (car lst) (helper (cdr lst)))))
  (define (sum-product lst)
    (if (null? lst)
        0
        (+ (helper (car lst)) (sum-product (cdr lst)))))
  (sum-product arr))

(define (find-sum arr)
  (magical-sequences arr))

(find-sum '((1 2) (3 4) (5 6)))