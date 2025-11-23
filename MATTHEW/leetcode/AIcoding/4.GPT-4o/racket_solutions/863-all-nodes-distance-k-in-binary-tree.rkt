#lang racket

(define (distanceK root target k)
  (define (build-graph node parent)
    (when node
      (define children (list))
      (when parent
        (set! children (cons parent children)))
      (set! children (append children (map (lambda (child) (build-graph child node)) (list (send node left) (send node right)))))
      (set! graph (cons (cons node children) graph)))
  (define (dfs node depth)
    (when node
      (if (= depth k)
          (set! result (cons (send node val) result))
          (for-each (lambda (child) (dfs child (+ depth 1))) (cdr (assoc node graph))))))
  (define (find-target node)
    (when node
      (if (equal? node target)
          (begin
            (dfs node 0)
            #t)
          (or (find-target (send node left)) (find-target (send node right))))))
  (define graph '())
  (define result '())
  (build-graph root #f)
  (find-target root)
  (reverse result))

(define (send obj method)
  (cond
    [(equal? method 'left) (car (vector-ref obj 1))]
    [(equal? method 'right) (cadr (vector-ref obj 1))]
    [(equal? method 'val) (vector-ref obj 0)]))

(define (create-node val left right)
  (vector val left right))