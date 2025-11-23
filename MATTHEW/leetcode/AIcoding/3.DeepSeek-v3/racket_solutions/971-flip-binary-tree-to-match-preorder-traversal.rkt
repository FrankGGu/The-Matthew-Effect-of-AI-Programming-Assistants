#lang racket

(define/contract (flip-match-voyage root voyage)
  (-> (or/c null? tree-node?) (listof exact-integer?) (listof exact-integer?))
  (define result '())
  (define idx 0)
  (define (dfs node)
    (if (null? node)
        #t
        (let ([val (tree-node-val node)])
          (if (not (= val (list-ref voyage idx)))
              #f
              (begin
                (set! idx (add1 idx))
                (if (and (not (null? (tree-node-left node)))
                         (not (null? (tree-node-right node)))
                    (if (not (= (tree-node-val (tree-node-left node)) (list-ref voyage idx)))
                        (begin
                          (set! result (cons val result))
                          (and (dfs (tree-node-right node))
                               (dfs (tree-node-left node))))
                        (and (dfs (tree-node-left node))
                             (dfs (tree-node-right node))))
                    (and (dfs (tree-node-left node))
                         (dfs (tree-node-right node)))))))))
  (if (dfs root)
      result
      '(-1)))

(define tree-node%
  (class object%
    (init-field val)
    (init-field [left #f])
    (init-field [right #f])
    (super-new)))

(define (tree-node val [left #f] [right #f])
  (new tree-node% [val val] [left left] [right right]))