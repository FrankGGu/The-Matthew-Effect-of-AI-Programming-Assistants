#lang racket

(define (make-tree . args)
  (cond ((null? args) #f)
        ((null? (cdr args)) (cons (car args) (cons #f #f)))
        (else (cons (car args)
                    (cons (apply make-tree (cadr args))
                          (apply make-tree (caddr args)))))))

(define (tree->list tree)
  (if (not tree)
      '()
      (append (tree->list (cadr tree))
              (list (car tree))
              (tree->list (caddr tree)))))

(define (prune-tree root)
  (cond ((not root) #f)
        ((and (not (cadr root)) (not (caddr root))) root)
        (else
         (let ((left (prune-tree (cadr root)))
               (right (prune-tree (caddr root))))
           (if (and (not left) (not right))
               #f
               (cons (car root) (cons left right))))))

(define (main)
  (define input (read))
  (define tree (apply make-tree input))
  (define result (prune-tree tree))
  (display (tree->list result)))

(main)