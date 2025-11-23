#lang racket

(struct TreeNode (val left right))

(define (serialize root)
  (define (build-list node)
    (if (not node)
        (list "#")
        (cons (number->string (TreeNode-val node))
              (append (build-list (TreeNode-left node))
                      (build-list (TreeNode-right node))))))
  (string-join (build-list root) ","))

(define (deserialize data)
  (define tokens (string-split data ","))

  (define (build-tree-from-list token-list)
    (if (empty? token-list)
        (values #f '())
        (let* ((token (car token-list))
               (rest (cdr token-list)))
          (if (string=? token "#")
              (values #f rest)
              (let* ((val (string->number token)))
                (call-with-values (lambda () (build-tree-from-list rest))
                  (lambda (left-node remaining-after-left)
                    (call-with-values (lambda () (build-tree-from-list remaining-after-left))
                      (lambda (right-node remaining-after-right)
                        (values (TreeNode val left-node right-node) remaining-after-right))))))))))

  (call-with-values (lambda () (build-tree-from-list tokens))
    (lambda (root _) root)))