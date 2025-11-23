(define RandomPickWithWeight
  (lambda (w)
    (define total (apply + w))
    (define cum-sums (map (lambda (x) (if (null? x) 0 (+ (if (null? (car (cdr x))) 0 (car (cdr x))) (car x)))) (scan + w)))
    (define pick
      (lambda ()
        (define rand (random total))
        (define index (find-index (lambda (x) (<= x rand)) cum-sums))
        index))
    (values pick)))

(define (find-index pred lst)
  (define (helper lst idx)
    (cond
      ((null? lst) -1)
      ((pred (car lst)) idx)
      (else (helper (cdr lst) (+ idx 1)))))
  (helper lst 0))

(define (scan op lst)
  (if (null? lst)
      '()
      (let loop ((acc 0) (lst lst))
        (if (null? lst)
            '()
            (let ((new-acc (op acc (car lst))))
              (cons new-acc (loop new-acc (cdr lst))))))))