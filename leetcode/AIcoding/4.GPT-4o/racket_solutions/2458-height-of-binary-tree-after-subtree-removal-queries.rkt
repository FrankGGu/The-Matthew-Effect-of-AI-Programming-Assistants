#lang racket

(define (treeHeightAfterQueries root queries)
  (define (height node)
    (if (null? node)
        0
        (+ 1 (max (height (car node)) (height (cadr node))))))

  (define (removeSubtree node)
    (if (null? node)
        0
        (let* ((left (car node))
               (right (cadr node))
               (lh (height left))
               (rh (height right)))
          (max lh rh))))

  (define original-height (height root))
  (map (lambda (query)
         (let ((subtree-root (list-ref root (car query))))
           (if (null? subtree-root)
               original-height
               (removeSubtree subtree-root))))
       queries))

(define root '((1 (2 (4 () ()) (5 () ())) (3 () ())))
(define queries '((0) (1) (2) (3)))

(treeHeightAfterQueries root queries)