#lang racket

(define (Node val)
  (define (make-node value)
    (define node (list value '() '()))
    (set-cdr! (cdr node) (list '() '()))
    node)
  (make-node val))

(define (insert-node node val)
  (if (null? node)
      (Node val)
      (let* ([left (cadr node)]
             [right (caddr node)]
             [new-node (Node val)])
        (if (null? left)
            (begin
              (set-cadr! node new-node)
              node)
            (if (null? right)
                (begin
                  (set-caddr! node new-node)
                  node)
                (if (< (random) 0.5)
                    (insert-node left val)
                    (insert-node right val)))))))

(define (CBTInserter root)
  (define tree (list))
  (define (traverse node)
    (when node
      (set! tree (append tree (list node)))
      (traverse (cadr node))
      (traverse (caddr node))))
  (traverse root)
  (define (insert val)
    (insert-node (car (last tree)) val))
  (define (get-root)
    root)
  (define (insert-root val)
    (set! root (insert val)))
  (define (get-tree)
    tree)
  (define (get-last)
    (last tree))
  (lambda (cmd . args)
    (cond
      [(equal? cmd 'insert) (insert (car args))]
      [(equal? cmd 'getRoot) (get-root)]
      [(equal? cmd 'getLast) (get-last)])))