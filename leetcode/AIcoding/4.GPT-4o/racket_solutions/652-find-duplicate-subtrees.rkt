#lang racket

(define (findDuplicateSubtrees tree)
  (define tree-map (make-hash))
  (define result '())

  (define (serialize node)
    (if (null? node)
        "#"
        (let* ((left (serialize (car node)))
               (right (serialize (cadr node)))
               (subtree (string-append (number->string (caddr node)) "," left "," right)))
          (hash-set! tree-map subtree (add1 (hash-ref tree-map subtree 0)))
          (when (= (hash-ref tree-map subtree) 2)
            (set! result (cons node result)))
          subtree)))

  (serialize tree)
  (reverse result))

(struct node (val left right) #:transparent)