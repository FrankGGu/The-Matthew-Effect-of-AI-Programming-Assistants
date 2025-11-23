#lang racket

(define (min-cost-to-change-final-value expression)
  (define (parse expr)
    (let loop ([expr expr] [stack '()])
      (cond [(null? expr) (car stack)]
            [(char=? (car expr) #\() (loop (cdr expr) (cons (list 'open) stack))]
            [(char=? (car expr) #\)) (loop (cdr expr) (cons (list 'close) stack))]
            [(char=? (car expr) #\+) (loop (cdr expr) (cons (list '+) stack))]
            [(char=? (car expr) #\-) (loop (cdr expr) (cons (list '-) stack))]
            [(char=? (car expr) #\*) (loop (cdr expr) (cons (list '*) stack))]
            [(char=? (car expr) #\/) (loop (cdr expr) (cons (list '/) stack))]
            [(char=? (car expr) #\ )] (loop (cdr expr) stack))
            [else (loop (cdr expr) (cons (list (string->number (string (car expr)))) stack))])))

  (define (evaluate expr cost)
    (let loop ([expr expr] [cost cost])
      (match expr
        [(list 'open) (loop (cdr expr) cost)]
        [(list 'close) (loop (cdr expr) cost)]
        [(list '+) (let* ([right (loop (cdr expr) cost)]
                         [left (loop (cdr expr) cost)])
                     (list (+ left right) cost))]
        [(list '-) (let* ([right (loop (cdr expr) cost)]
                         [left (loop (cdr expr) cost)])
                     (list (- left right) cost))]
        [(list '*) (let* ([right (loop (cdr expr) cost)]
                         [left (loop (cdr expr) cost)])
                     (list (* left right) cost))]
        [(list '/) (let* ([right (loop (cdr expr) cost)]
                         [left (loop (cdr expr) cost)])
                     (list (quotient left right) cost))]
        [(list (and x (app number? _))) (list x cost)])))

  (define (costs expr)
    (let loop ([expr expr] [costs '()])
      (cond [(null? expr) (reverse costs)]
            [(equal? (car expr) 'open) (loop (cdr expr) costs)]
            [(equal? (car expr) 'close) (loop (cdr expr) costs)]
            [(or (equal? (car expr) '+) (equal? (car expr) '-) (equal? (car expr) '*) (equal? (car expr) '/)) 
             (loop (cdr expr) costs)]
            [else (loop (cdr expr) (cons (if (number? (car expr)) 0 1) costs))]))

  (define parsed (parse (string->list expression)))
  (define cost-list (costs parsed))

  (define (build-tree expr)
    (let loop ([expr expr] [costs cost-list] [values '()] [ops '()])
      (cond [(null? expr) (cons (car values) (reverse ops))]
            [(equal? (car expr) 'open) (loop (cdr expr) costs values ops)]
            [(equal? (car expr) 'close) (loop (cdr expr) costs values ops)]
            [(or (equal? (car expr) '+) (equal? (car expr) '-) (equal? (car expr) '*) (equal? (car expr) '/))
             (loop (cdr expr) costs (cons (car ops) (cons (car values) (cdr values))) (cons (car expr) (cdr ops)))]
            [else (loop (cdr expr) (cdr costs) (cons (car expr) values) ops)]))

  (define (compute-values tree)
    (let loop ([tree tree] [values '()])
      (match tree
        [(list v op ...) (loop op (cons v values))]
        [(list v op ...) (loop op (cons v values))]
        [(list v) (list v)])))

  (define (compute-costs tree)
    (let loop ([tree tree] [costs '()])
      (match tree
        [(list v op ...) (loop op (cons 0 costs))]
        [(list v) (reverse costs)])))

  (define (eval-with-costs tree costs)
    (let loop ([tree tree] [costs costs] [value 0])
      (match tree
        [(list v op ...) (let* ([c (car costs)]
                               [v1 (loop op (cdr costs) 0)]
                               [v2 (loop op (cdr costs) 0)])
                           (list (+ v1 v2) c))]
        [(list v) (list v 0)])))

  (define tree (build-tree parsed))
  (define value (car tree))
  (define ops (cdr tree))

  (define (min-cost value ops costs)
    (if (null? ops)
        0
        (let* ([op (car ops)]
               [left (min-cost (car value) (cadr ops) (cddr costs))]
               [right (min-cost (caddr value) (cadddr ops) (cddddr costs))]
               [current-cost (if (equal? op '+) (abs (- value (+ left right))) (abs (- value (- left right))))]
               [new-cost (if (equal? op '+) (abs (- value (+ left right))) (abs (- value (- left right))))]
               [total-cost (+ new-cost left right)])
          total-cost)))

  (min-cost value ops cost-list))