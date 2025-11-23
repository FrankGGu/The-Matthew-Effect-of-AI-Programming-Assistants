#lang racket

(define (tree-maximum-value root)
  (if (not root)
      '()
      (let ((result '()))
        (define (bfs queue)
          (when (not (null? queue))
            (let ((current-level (map car queue))
                  (next-queue '()))
              (set! result (append result (list (apply max current-level))))
              (for-each
               (lambda (node)
                 (when (not (null? (node-left node)))
                   (set! next-queue (append next-queue (list (node-left node)))))
                 (when (not (null? (node-right node)))
                   (set! next-queue (append next-queue (list (node-right node))))))
               (map car queue))
              (bfs next-queue))))
        (bfs (list root))
        result)))

(define (node-left node) (cadr node))
(define (node-right node) (caddr node))

(define (main)
  (define root (list 1 (list 3 (list 5 null null) null) (list 2 null (list 6 null null))))
  (tree-maximum-value root))