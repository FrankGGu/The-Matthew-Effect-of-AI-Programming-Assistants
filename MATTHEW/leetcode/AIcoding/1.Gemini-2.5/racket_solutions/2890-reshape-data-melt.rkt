#lang racket

(define (melt table id-vars value-vars)
  (let* ([header (car table)]
         [data (cdr table)]
         [id-var-indices (map (lambda (var) (index-of header var)) id-vars)]
         [value-var-indices (map (lambda (var) (index-of header var)) value-vars)]
         [new-header (append id-vars (list "variable" "value"))])

    (define (index-of lst item)
      (define (loop lst idx)
        (cond
          [(empty? lst) #f]
          [(equal? (car lst) item) idx]
          [else (loop (cdr lst) (+ idx 1))]))
      (loop lst 0))

    (cons new-header
          (apply append
           (map (lambda (row)
                  (let ([id-values (map (lambda (idx) (list-ref row idx)) id-var-indices)])
                    (map (lambda (val-var-name val-var-idx)
                           (append id-values (list val-var-name (list-ref row val-var-idx))))
                         value-vars
                         value-var-indices)))
                data)))))