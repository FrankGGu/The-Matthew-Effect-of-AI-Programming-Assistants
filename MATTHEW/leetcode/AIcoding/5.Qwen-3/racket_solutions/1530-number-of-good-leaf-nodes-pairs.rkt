#lang racket

(define (number-of-good-leaf-node-pairs root distance)
  (define (dfs node)
    (if (not node)
        '()
        (let* ([left (dfs (car node))]
               [right (dfs (cadr node))]
               [leaves (append left right)])
          (if (and (not (car node)) (not (cadr node)))
              (list '())
              (let ([new-leaves (map (lambda (x) (+ x 1)) leaves)])
                (for-each (lambda (l) (when (>= l distance) (set! count (+ count 1)))) new-leaves)
                new-leaves)))))

  (define count 0)
  (dfs root)
  count)