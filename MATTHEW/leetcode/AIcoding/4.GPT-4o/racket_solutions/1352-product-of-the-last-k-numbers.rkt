(define ProductOfNumbers
  (lambda ()
    (define nums '())
    (define (add num)
      (set! nums (cons num nums)))
    (define (getProduct k)
      (if (or (null? nums) (<= k 0))
          1
          (let loop ((lst nums) (count 0) (product 1))
            (cond
              ((null? lst) product)
              ((< count k) (loop (cdr lst) (+ count 1) (* product (car lst))))
              (else product)))))
    (define (reset)
      (set! nums '()))
    (lambda (cmd . args)
      (cond
        ((equal? cmd 'add) (add (car args)))
        ((equal? cmd 'getProduct) (getProduct (car args)))
        ((equal? cmd 'reset) (reset))))))

(define op (ProductOfNumbers))
(op 'add 3)
(op 'add 0)
(op 'add 2)
(op 'getProduct 3)
(op 'reset)
(op 'getProduct 3)