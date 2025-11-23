#lang racket

(define (minimum-operations root)
  (define (level-order-traversal node)
    (define (helper queue result)
      (if (null? queue)
          result
          (let* ([current (car queue)]
                 [next-level (append (if (not (null? (node-left current))) (list (node-left current)) '())
                                     (if (not (null? (node-right current))) (list (node-right current)) '()))]
                 [new-result (append result (list (node-val current)))])
            (helper (append (cdr queue) next-level) new-result))))
    (helper (list root) '()))

  (define (sort-levels levels)
    (define (get-levels-values levels)
      (map (lambda (level) (map node-val level)) levels))

    (define (get-levels nodes)
      (define (helper queue result)
        (if (null? queue)
            result
            (let* ([current (car queue)]
                   [next-level (append (if (not (null? (node-left current))) (list (node-left current)) '())
                                       (if (not (null? (node-right current))) (list (node-right current)) '()))]
                   [new-result (append result (list (list current)))])
              (helper (append (cdr queue) next-level) new-result))))
      (helper (list root) '()))

    (define levels (get-levels-values (get-levels root)))
    (define sorted-levels (map sort levels))
    (define (count-mismatches l1 l2)
      (for/sum ([a l1] [b l2]) (if (= a b) 0 1)))

    (apply + (map count-mismatches levels sorted-levels)))

  (sort-levels (level-order-traversal root)))