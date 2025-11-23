#lang racket

(define (findBottomLeftValue root)
  (define (helper node depth)
    (if (null? node)
        (values '() -1)
        (let-values ([(left-value left-depth) (helper (node-left node) (+ depth 1))]
                     [(right-value right-depth) (helper (node-right node) (+ depth 1))])
          (if (> left-depth right-depth)
              (values left-value left-depth)
              (values right-value right-depth)))))

  (define (traverse node)
    (if (null? node)
        '()
        (cons (node-val node)
              (append (traverse (node-left node)) (traverse (node-right node))))))

  (define (find-bottom-left node)
    (let-values ([(value depth) (helper node 0)])
      (node-val (first (filter (lambda (n) (equal? (length (traverse n)) depth))
                                (traverse node))))))

  (find-bottom-left root))