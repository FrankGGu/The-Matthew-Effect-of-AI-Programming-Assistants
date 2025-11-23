(define contaminate (lambda (root)
  (letrec ((helper (lambda (node val)
                     (cond
                       [(null? node) #f]
                       [else
                        (set! (car node) val)
                        (helper (cdr node) (+ (* 2 val) 1))
                        (helper (cddr node) (+ (* 2 val) 2))]))))
    (helper root 0)
    root)))

(define (find tree target)
  (letrec ((helper (lambda (node target)
                     (cond
                       [(null? node) #f]
                       [(= (car node) target) #t]
                       [else (or (helper (cdr node) target)
                                 (helper (cddr node) target))]
                       ))))
    (helper tree target)))

(define FindElements%
  (class object%
    (init root)
    (define/public tree (contaminate root))
    (define/public find find)
    (super-new)))

(define (make-FindElements root)
  (new FindElements% [root root]))