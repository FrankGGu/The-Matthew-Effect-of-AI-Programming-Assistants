#lang racket

(define-struct node (val left right) #:mutable)

(define (create-tree lst)
  (if (null? lst)
      #f
      (let loop ([nodes (map (lambda (x) (make-node x #f #f)) lst)]
                 [i 0])
        (if (>= i (length nodes))
            #f
            (let ([n (list-ref nodes i)])
              (set-node-left! n (if (< (* 2 i) (length nodes)) (list-ref nodes (* 2 i)) #f))
              (set-node-right! n (if (< (+ (* 2 i) 1) (length nodes)) (list-ref nodes (+ (* 2 i) 1)) #f))
              n)))))

(define (insert root val)
  (let ([new-node (make-node val #f #f)])
    (let loop ([queue (list root)])
      (cond
        [(null? queue) #f]
        [else
         (let ([current (car queue)])
           (if (not (node-left current))
               (begin
                 (set-node-left! current new-node)
                 new-node)
               (if (not (node-right current))
                   (begin
                     (set-node-right! current new-node)
                     new-node)
                   (loop (append (cdr queue) (list (node-left current) (node-right current)))))))]))))

(define (get-root root)
  root)