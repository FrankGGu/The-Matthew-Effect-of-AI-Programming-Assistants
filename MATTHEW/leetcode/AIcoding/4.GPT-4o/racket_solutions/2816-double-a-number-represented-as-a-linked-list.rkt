#lang racket

(define (double-it head)
  (define (reverse lst)
    (define (rev-helper lst acc)
      (if (null? lst)
          acc
          (rev-helper (cdr lst) (cons (car lst) acc))))
    (rev-helper lst '()))

  (define (add-one lst)
    (define (add-helper lst carry)
      (if (null? lst)
          (if (= carry 0) '() (cons 1 '()))
          (let* ((sum (+ (car lst) carry))
                 (new-carry (if (>= sum 10) 1 0))
                 (new-value (modulo sum 10)))
            (cons new-value (add-helper (cdr lst) new-carry)))))
    (add-helper (reverse lst) 0))

  (define (to-list node)
    (if (null? node)
        '()
        (cons (node-val node) (to-list (node-next node)))))

  (define (from-list lst)
    (if (null? lst)
        null
        (make-node (car lst) (from-list (cdr lst)))))

  (from-list (add-one (to-list head)))
)