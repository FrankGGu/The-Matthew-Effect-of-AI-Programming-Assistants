#lang racket

(define/contract (decorate-record root)
  (-> (or/c null? (list/c integer? (or/c null? (list/c any/c)) (or/c null? (list/c any/c)))) (listof (listof integer?)))
  (if (null? root)
      '()
      (let loop ([nodes (list root)] [left-to-right #f])
        (if (null? nodes)
            '()
            (let ([vals (map (λ (node) (car node)) nodes)]
                  [next-nodes (apply append (map (λ (node) (filter (λ (x) (not (null? x))) (cdr node))) nodes))])
              (cons (if left-to-right vals (reverse vals))
                    (loop next-nodes (not left-to-right))))))))